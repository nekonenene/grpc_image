# gRPC image

gRPC with Go (golang) and Docker 


## Requirement

* Docker


## Usage

1. Build images.  
    ```sh
    make build
    ```
2. Run the container to start the gRPC server.  
    ```sh
    make run
    ```


## Development

1. Put symlink, but **it's not necessary** if you develop in the docker container.  
    ```sh
    make init
    ```
2. When update `hello.proto`, you should also update `hello.pb.go`.  
    ```sh
    make pb_hello
    ```
3. Whn update `main.go`, rebuild the image and rerun the container.
    ```sh
    make build_hello
    make run_hello
    ```
