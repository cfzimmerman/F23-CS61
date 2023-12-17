#include "mpsc.hh"
#include <cstdio>
#include <memory>
#include <thread>

/// This test verifies that channels are able to communicate
/// with eachother by passing senders back and forth.
/// Many threads are spawned, and they send a message back
/// to the parent, which is supposed to send a message back to
/// the spawned thread. After that, the thread exits.

const size_t THREAD_CT = 150;
const int REPLY = 40;

struct comm {
    std::shared_ptr<sender<int>> tx;
};

// void send_counters(std::shared_ptr<sender<long>> tx, long val) {
void invoke_partner(std::shared_ptr<sender<comm>> tx) {
    receiver<int> oneshot = receiver<int>();
    tx->send({oneshot.spawn_sender()});
    int reply = oneshot.receive();
    assert(reply == REPLY);
}

int main() {
    receiver<comm> channel = receiver<comm>();
    std::vector<std::thread> threads;

    for (size_t ct = 0; ct < THREAD_CT; ct++) {
        threads.push_back(std::thread(invoke_partner, channel.spawn_sender()));
    }

    // Looping explicitly because this pattern requires us to
    // know how many responses we expect.
    for (size_t ct = 0; ct < THREAD_CT; ct++) {
        comm received = channel.receive();
        received.tx->send(REPLY);
    }

    printf("✅ communicated with %ld threads\n", THREAD_CT);

    for (std::thread& th : threads) {
        th.join();
    }

    return 0;
}
