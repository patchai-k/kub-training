The list of what needs to be fixed and how to fix it in the
troubleshooting lab is below.

1. Deployment: web

    Incorrect/original:

    ```
    image: gcr.io/dduck-quack/puddle:9.8
    ```

    Correct:

    ```
    image: gcr.io/timf-gcp-404004/web:2.4
    ```
1. Deployment: web

    Incorrect/original:

    ```
    ...
    livenessProbe:
      httpGet:
        path: /earth
    ...
    ```

    Correct:

    ```
    ...
    livenessProbe:
      httpGet:
        path: /locations
    ...
    ```

1. Service: web

    Incorrect/original:

    ```
     app: thelocationapp
    ```

    Correct:

    ```
     app: web
    ```
