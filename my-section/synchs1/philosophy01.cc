#include <cstdio>
#include <cassert>
#include <unistd.h>
#include <random>
#include <thread>
#include <mutex>
#include <condition_variable>

static constexpr int K = 8;   // number of stalls

unsigned long long stalls[K];

void wait_until_uncomfortable() {
    // stoic philosophers are always comfortable
}

[[gnu::noinline]] // prevent compiler optimization
void poop_into(int stall) {
    stalls[stall] += 1;
}

void user(int preferred_stall) {
    while (true) {
        wait_until_uncomfortable();
        poop_into(preferred_stall);
    }
}

int main() {
    std::default_random_engine randomness((std::random_device())());
    std::uniform_int_distribution<int> pick_stall(0, K - 1);

    for (size_t i = 0; i != 32; ++i) {
        std::thread t(user, pick_stall(randomness));
        t.detach();
    }

    sleep(5);

    // NB: data races here
    for (int i = 0; i != K; ++i) {
        printf("stalls[%d] = %llu\n", i, stalls[i]);
    }
}
