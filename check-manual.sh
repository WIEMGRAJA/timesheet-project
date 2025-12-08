#!/bin/bash
echo "=== VÉRIFICATION MANUELLE CHAPITRE 4 ==="

# Vérifications critiques
echo "1. Java:"
java -version 2>&1 | grep "version" && echo "✅ JAVA OK"

echo "2. Maven:"
mvn --version 2>&1 | grep "Apache Maven" && echo "✅ MAVEN OK"

echo "3. Git:"
git --version 2>&1 | grep "git version" && echo "✅ GIT OK"

echo "4. Jenkins:"
sudo systemctl is-active jenkins && echo "✅ JENKINS OK"

echo "5. Docker:"
docker --version 2>&1 | grep "Docker version" && echo "✅ DOCKER OK"

echo "6. Application:"
curl -s http://localhost:8080/ >/dev/null && echo "✅ APP PORT 8080 OK" || \
curl -s http://localhost:8083/ >/dev/null && echo "✅ APP PORT 8083 OK" || \
echo "⚠️  APP NON ACCESSIBLE"

echo "7. GitHub:"
git remote -v | grep github.com && echo "✅ GITHUB OK"

echo "=== CHAPITRE 4 PRÊT ==="
