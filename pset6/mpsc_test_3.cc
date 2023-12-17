#include "mpsc.hh"
#include <cstdio>
#include <memory>
#include <thread>

/// This test verifies that multiple channels can be instantiated
/// and working simultaneously without messing with eachother.

const long SEND_CT = 250;
const long THREAD_CT = 50;

const long CHANNEL_1_VAL = -3;
const long CHANNEL_2_VAL = 7;


void send_counters(std::shared_ptr<sender<long>> tx, long val) {
    for (size_t ct = 0; ct < SEND_CT; ct++) {
        tx->send(val);
    }
}

int main() {
    receiver<long> channel_one = receiver<long>();
    receiver<long> channel_two = receiver<long>();

    long channel_one_spawned = 0;
    long channel_two_spawned = 0;

    std::vector<std::thread> threads;
    for (size_t ct = 0; ct < THREAD_CT; ct++) {
        if (ct % 2 == 0) {
            threads.push_back(std::thread(send_counters, channel_one.spawn_sender(), CHANNEL_1_VAL));
            channel_one_spawned++;
            continue;
        }
        threads.push_back(std::thread(send_counters, channel_two.spawn_sender(), CHANNEL_2_VAL));
        channel_two_spawned++;
    }

    assert(channel_one_spawned + channel_two_spawned == THREAD_CT);

    long channel_one_ct = 0;
    for (int ct = 0; ct < channel_one_spawned * SEND_CT; ct++) {
        long received = channel_one.receive();
        channel_one_ct += received;
    }

    long channel_two_ct = 0;
    for (int ct = 0; ct < channel_two_spawned * SEND_CT; ct++) {
        long received = channel_two.receive();
        channel_two_ct += received;
    }

    assert(channel_one_ct == channel_one_spawned * CHANNEL_1_VAL * SEND_CT);
    assert(channel_two_ct == channel_two_spawned * CHANNEL_2_VAL * SEND_CT);

    printf("✅ channel one: %ld, channel two: %ld\n", channel_one_ct, channel_two_ct);

    for (std::thread& th : threads) {
        th.join();
    }

    return 0;
}
