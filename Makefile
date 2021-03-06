all:

init:
	rm -f .git/hooks/pre-push
	rm -f .git/hooks/pre-commit
	ln -s ../../githooks/pre-push .git/hooks/pre-push
	ln -s ../../githooks/pre-commit .git/hooks/pre-commit
	go get github.com/samuel/go-thrift/parser
	go get github.com/spf13/cobra/cobra
	go get github.com/jteeuwen/go-bindata/...

test: buildTpl
	go test ./...

test-go-gen: buildTpl
	rm -rf thriftgotest
	go build
	./tgen gen -l go -i example/golang/Enum.thrift -o ../../../
	./tgen gen -l go -i example/golang/Const.thrift -o ../../../
	./tgen gen -l go -i example/golang/IncludeEnum.thrift -o ../../../
	./tgen gen -l go -i example/golang/Types.thrift -o ../../../
	./tgen gen -l go -r --validate -i example/golang/Service.thrift -o ../../../
	./tgen gen -l go -i example/golang/SimpleArguments.thrift -o ../../../
	./tgen gen -l go -w=false -i example/golang/UnusedInclude.thrift -o ../../../
	go install github.com/ezbuy/tgen/thriftgotest/...

test-go-ezrpc: test-go-gen
	ezrpc gen -l go -i example/golang/Service.thrift -o ../../../
	go install github.com/ezbuy/tgen/thriftgotest/...

buildTpl:
	go-bindata -o tmpl/bindata.go -ignore bindata.go -pkg tmpl tmpl/*

debugTpl:
	go-bindata -o tmpl/bindata.go -ignore bindata.go -pkg tmpl -debug tmpl/*

gen-java: gen-java-rest gen-java-jsonrpc

gen-java-jsonrpc: buildTpl
	rm -rf output-java-jsonrpc
	go run main.go gen -l java -m jsonrpc -i example/java/ShipForMe.thrift -o ./output-java-jsonrpc

gen-java-rest: buildTpl
	rm -rf output-java-rest
	go run main.go gen -l java -m rest -i example/java/ShipForMe.thrift -o ./output-java-rest

gen-swift-rest: buildTpl
	rm -rf output-swift-rest
	go run main.go gen -l swift -m rest -i example/swift/Example.thrift -o ./output-swift-rest

gen-swift-jsonrpc: buildTpl
	rm -rf output-swift-jsonrpc
	go run main.go gen -l swift -m jsonrpc -i example/swift/Example.thrift -o ./output-swift-jsonrpc

gen-swift: gen-swift-rest gen-swift-jsonrpc

clean:
	go clean
	rm -rf ./output-swift-rest
	rm -rf ./output-swift-jsonrpc
	rm -rf ./output-java-rest
	rm -rf ./output-java-jsonrpc

build:
	go clean
	go build
	open .
