#include <condition_variable>
#include <cstdio>
#include <cstdlib>
#include <memory>
#include <mutex>
#include <queue>

/// This header file started as a ring buffer channel. I downgraded
/// it to a locked queue while trying to sanity check my tests.
/// Tbh it's about as fast as the ring buffer was, so I'm keeping it
/// like this.

template <typename T>
/// The reference counted object holding the shared resources
/// of the receiver and senders.
class channel {
  public:
    /// The lock must be held to access the queue (read or write).
    std::mutex lock = std::mutex();
    /// Stores the channel data.
    std::queue<T> queue = std::queue<T>();
    /// Used to wake the reader when new data has been sent.
    std::condition_variable cv = std::condition_variable();
};

template <typename T>
class sender {
  public:
    sender(std::shared_ptr<channel<T>> channel_ref) : ch(channel_ref){};

    /// Writes data to the queue.
    void send(T msg);

  private:
    std::shared_ptr<channel<T>> ch;
};

template <typename T>
void sender<T>::send(T msg) {
    std::unique_lock lk(ch->lock);
    ch->queue.push(msg);
    ch->cv.notify_all();
}

template <typename T>
class receiver {
  public:
    /// Reads data from the queue.
    T receive();

    /// Spawns a sender that writes data to this queue.
    std::shared_ptr<sender<T>> spawn_sender();

    receiver() {
        ch = std::make_shared<channel<T>>();
    }

  private:
    std::shared_ptr<channel<T>> ch;
};

template <typename T>
T receiver<T>::receive() {
    while (true) {
        std::unique_lock lock(ch->lock);
        if (!ch->queue.empty()) {
            T val = ch->queue.front();
            ch->queue.pop();
            return val;
        }
        ch->cv.wait(lock);
    }
}

template <typename T>
std::shared_ptr<sender<T>> receiver<T>::spawn_sender() {
    return std::make_shared<sender<T>>(ch);
}
