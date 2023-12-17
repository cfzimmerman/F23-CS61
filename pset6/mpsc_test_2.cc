#include "mpsc.hh"
#include <cstdio>
#include <memory>
#include <thread>

/// Spawns many threads, and each thread wants to send many
/// messages. The channel size is also a more realistic, and
/// we're sending structs instead of just integers.

const size_t SEND_CT = 500;
const size_t THREAD_CT = 100;

const long long FIRST_NUM = -5;
const long long SECOND_NUM = 6;

struct counter {
    long long first;
    long long second;
};

void send_counters(std::shared_ptr<sender<counter>> tx) {
    for (size_t ct = 0; ct < SEND_CT; ct++) {
        tx->send(counter{FIRST_NUM, SECOND_NUM});
    }
}

int main() {
    receiver<counter> channel = receiver<counter>();
    std::vector<std::thread> threads;

    for (size_t ct = 0; ct < THREAD_CT; ct++) {
        threads.push_back(std::thread(send_counters, channel.spawn_sender()));
    }

    int total_ct = 0;

    size_t expected_messages = SEND_CT * THREAD_CT;

    for (size_t ct = 0; ct < expected_messages; ct++) {
        counter received = channel.receive();
        total_ct += received.first;
        total_ct += received.second;
    }

    assert(total_ct == THREAD_CT * SEND_CT * (FIRST_NUM + SECOND_NUM));
    printf("✅ counter channel received: %d\n", total_ct);

    for (std::thread& th : threads) {
        th.join();
    }

    return 0;
}
