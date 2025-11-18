#!/bin/bash
# Session start hook for GradesCentral API
# This script runs when a new Claude Code session starts

echo "🚀 Starting GradesCentral API session..."

# Check Ruby version
if command -v ruby &> /dev/null; then
    RUBY_VERSION=$(ruby -v)
    echo "✓ Ruby: $RUBY_VERSION"
else
    echo "⚠ Ruby not found"
fi

# Check if bundler is installed
if command -v bundle &> /dev/null; then
    echo "✓ Bundler installed"
else
    echo "⚠ Bundler not found - run: gem install bundler"
fi

# Check if dependencies are installed
if [ -f "Gemfile.lock" ]; then
    if bundle check &> /dev/null; then
        echo "✓ Bundle dependencies installed"
    else
        echo "⚠ Bundle dependencies missing - run: bundle install"
    fi
fi

# Check for database configuration
if [ -f "config/database.yml" ]; then
    echo "✓ Database configuration found"
else
    echo "⚠ Database configuration missing - create config/database.yml"
fi

# Check for environment file
if [ -f ".env" ]; then
    echo "✓ Environment configuration found"
else
    echo "⚠ Environment file missing - copy .env.example to .env"
fi

# Check Elasticsearch connection
if command -v curl &> /dev/null; then
    if curl -s http://localhost:9200 &> /dev/null; then
        echo "✓ Elasticsearch running at localhost:9200"
    else
        echo "⚠ Elasticsearch not accessible at localhost:9200"
    fi
fi

echo ""
echo "📝 Available commands:"
echo "  /test     - Run the test suite"
echo "  /server   - Start Rails development server"
echo "  /migrate  - Run database migrations"
echo "  /routes   - Display all API routes"
echo "  /reindex  - Reindex Elasticsearch data"
echo ""
echo "Ready to code! 🎉"
