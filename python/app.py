from __future__ import print_function
import os
from time import sleep
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import os.path 

class ScreenshotEventHandler(FileSystemEventHandler):
    def on_created(self, event):
        #print(event)
        sleep(.03) #There's some problem with the file not finishing writing before this function is called, so this
                   #sleep homes to correct that issue
        fpath = event.src_path
        try:
            with open(fpath, 'rb') as f:
                z = f.read()
                print('read {0} from {1}'.format(z[:50], fpath))
            os.remove(fpath)
        except IOError:
            print("File access occurred too soon...")
            return
        with open(os.path.join('comm', 'comm.txt'), 'w') as f:
            # init value of self.i
            try:
                k = self.i
            except:
                self.i = 0
            f.write('{0} {1} {2}'.format(self.i, 0, 0))
            self.i += .01
            print('Wrote to {0} val {1}'.format(f.name, self.i))

if __name__ == "__main__":
    event_handler = ScreenshotEventHandler()
    observer = Observer()
    observer.schedule(event_handler, os.path.join('USER', 'ScreenShots/'))
    observer.start()
    try:
        while True:
            sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join() #observer is a thread, and this is the threading.join method

