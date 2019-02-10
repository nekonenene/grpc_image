# gRPC image

gRPC with Go (golang) and Docker 


## Requirement

* Docker


## Usage

1. Build images.  
    ```sh
    make build
    ```
2. Run server.  
    ```sh
    make run
    ```


## Development

1. Put symlink, but **it's not necessary** if you develop in the docker image.  
    ```sh
    make init
    ```
2. When update `hello.proto`, you should also update `hello.pb.go`.  
    ```sh
    make pb_hello
    ```
3. Whn update `main.go`, rebuild and rerun the image.
    ```sh
    make build_hello
    make run_hello
    ```
