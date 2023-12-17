#include "rw_rec.hh"
#include <cassert>
#include <cstdio>
#include <memory>
#include <mutex>
#include <shared_mutex>
#include <thread>
#include <vector>


/// Verifies that a thread may have two writers with other
/// readers kept out. Also verifies that multiple readers can
/// share a read only lock.

const int NUM_THREADS = 5;

const int VAL_1 = 4;
const int VAL_2 = 5;

struct shareable {
    rw_rec mtx;
    int num = VAL_1;
};

void read_shareable(std::shared_ptr<shareable> asset) {
    std::shared_lock<rw_rec> lk(asset->mtx);
    assert(asset->num == VAL_2);
}

int main() {
    std::shared_ptr<shareable> asset = std::make_shared<shareable>();
    // lock is initially claimable
    std::unique_lock lk1(asset->mtx, std::defer_lock);
    assert(lk1.try_lock());
    // the same thread can have multiple writers simultaneously
    std::unique_lock lk2(asset->mtx);
    // the same thread cannot mix readers and writers
    assert(!asset->mtx.try_lock_shared());

    std::vector<std::thread> threads;

    for (int ct = 0; ct < NUM_THREADS; ct++) {
        threads.push_back(std::thread(read_shareable, asset));
    }

    asset->num = VAL_2;

    lk1.unlock();
    lk2.unlock();

    for (std::thread& th : threads) {
        th.join();
    }

    printf("✅ passed rw_rec test 1\n");
}
