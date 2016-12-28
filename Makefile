all: test

clean:
	@swift build --clean=dist

xcode:
	@rm -rf postgresql.xcodeproject
	@swift package generate-xcodeproj

build:
	@swift build

test: build
	@swift test
