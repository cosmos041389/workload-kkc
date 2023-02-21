name := "pagerank"

version := "1.0"

scalaVersion := "2.12.17"

artifactPath in (Compile, packageBin) := file("/home/cosmos/workload-kkc/datasets/spark") / s"${name.value}.jar"

libraryDependencies ++= Seq(
    "org.apache.spark" %% "spark-sql" % "3.3.1",
    "org.scalanlp" %% "breeze" % "2.1.0",
)
