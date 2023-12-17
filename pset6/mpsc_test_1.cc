#include "mpsc.hh"
#include <cassert>
#include <cstdio>
#include <memory>
#include <thread>
#include <vector>

/// Spawns many threads, and each tries to send one int down
/// a single-shot channel.
/// Internally, the channel's minimum size is upgraded to two, but
/// this gives a good idea on how the channel performs under pressure
/// from a ton of lightweight senders hitting all at once.

static const int NUM_THREADS = 250;
static const int VAL = 5;

void send_single(std::shared_ptr<sender<int>> tx, int val) {
    tx->send(val);
}

int main() {
    receiver<int> tiny_channel = receiver<int>();
    std::vector<std::thread> threads;

    for (int ct = 0; ct < NUM_THREADS; ct++) {
        threads.push_back(std::thread(send_single, tiny_channel.spawn_sender(), VAL));
    }

    int total_ct = 0;

    for (int ct = 0; ct < NUM_THREADS; ct++) {
        int received = tiny_channel.receive();
        total_ct += received;
    }

    assert(total_ct == NUM_THREADS * VAL);
    printf("✅ tiny channel received: %d\n", total_ct);

    for (std::thread& th : threads) {
        th.join();
    }

    return 0;
}
