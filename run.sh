#!/bin/sh
set -eu
cd "$(dirname "$0")"
exec mvn -Dmaven.repo.local=target/m2-repository compile exec:java -Dexec.mainClass=com.codequest.CodeQuestServer
