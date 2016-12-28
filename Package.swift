import PackageDescription

let package = Package(
  name: "postgresql",

  targets: [
    Target(name: "postgresql"),
  ],

  dependencies: [
    .Package(url: "https://github.com/cargodb/libpostgresql", majorVersion:  0),
  ]
)
