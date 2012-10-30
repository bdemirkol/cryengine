from __future__ import print_function
import time
import logging
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler, FileSystemEventHandler

class ScreenshotEventHandler(FileSystemEventHandler):
    #def on_any_event(self, event):
    #    print(event)
    def on_created(self, event):
        print(event)

if __name__ == "__main__":
    #logging.basicConfig(level=logging.INFO,
    #                    format='%(asctime)s - %(message)s',
    #                    datefmt='%Y-%m-%d %H:%M:%S')
    #event_handler = LoggingEventHandler()
    event_handler = ScreenshotEventHandler()
    observer = Observer()
    observer.schedule(event_handler, '.', recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join() #observer is a thread, and this is the threading.join method

