#!/bin/bash
# setup-hooks.sh — Installe les hooks locaux

set -e

echo "=== Installation des hooks locaux NexaCloud ==="

# 1. Installer pre-commit
if ! python -m pre_commit --version &>/dev/null; then
    echo "Installation de pre-commit..."
    python -m pip install pre-commit --quiet
fi

# 2. Activer les hooks pre-commit
python -m pre_commit install
echo "✅ Hooks pre-commit activés"

# 3. Installer le hook pre-push
cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash
echo "[pre-push] Lancement des tests..."
cd ressources && pytest -q
EXIT_CODE=$?
cd ..
[ $EXIT_CODE -ne 0 ] && echo "❌ Tests échoués — push bloqué" && exit 1
echo "✅ Tests passés — push autorisé"
EOF

chmod +x .git/hooks/pre-push
echo "✅ Hook pre-push installé"

echo ""
echo "=== Hooks installés avec succès ==="
echo "  pre-commit : flake8 + trailing-whitespace + check-yaml"
echo "  pre-push   : pytest"
