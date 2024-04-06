import cv2

face_detector = cv2.CascadeClassifier('./data/haarcascade_frontalface_default.xml')

video_capture = cv2.VideoCapture(0)
address = "http://192.168.1.7:8080/video"
video_capture.read(address)

while True:
    # Capture frame-by-frame
    ret, frame = video_capture.read()

    image_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    detections = face_detector.detectMultiScale(image_gray, minSize=(100,100))

    # Draw a rectangle around the faces
    for (x, y, w, h) in detections:
        print(w, h)
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

    # Display the resulting frame
    cv2.imshow('Video', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()