# ERC3643 Template

A comprehensive Solidity development template for ERC3643 related projects, featuring modern development tools and best practices.

## 🏗️ Architecture Overview

This template provides a robust foundation for Solidity smart contract development with the following key components:

### Core Development Framework
- **Foundry** - Fast, portable and modular toolkit for Ethereum application development
- **Forge** - Testing framework for Foundry with built-in fuzzing and invariant testing

### Code Quality & Formatting
- **Forge Format** - Built-in Solidity code formatting

### Git Hooks & Workflow
- **Husky** - Git hooks for automated quality checks
- **Pre-commit Hooks** - Automated formatting and coverage checks
- **Commitlint** - With gitmoji commit message validation

## 🚀 Getting Started

### Prerequisites
- [Foundry](https://getfoundry.sh/) - Install Foundry toolkit
- [npm](https://npmjs.com/) - For packages management

### Installation

1. **Clone the template**
   ```bash
   git clone <repository-url>
   cd contracts-template
   ```

2. **Install dependencies**
   ```bash
   # Install Node.js dependencies, Husky and Solidity libraries
   npm install
   ```

3. **Build the project**
   ```bash
   # Build with Forge
   forge build
   ```

## 🛠️ Development Commands

### NPM Scripts
```bash
# Build contracts
npm run build

# Run tests
npm run test

# Check formatting
npm run lint

# Fix formatting
npm run lint:fix

# Generate coverage report
npm run coverage:report

# Generate documentation
npm run docs
```

## 📁 Project Structure

```
template/
├── contracts/          # Smart contract source files
├── test/              # Test files (Foundry .sol)
├── scripts/           # Deployment and utility scripts
├── .husky/            # Git hooks configuration
├── .github/           # GitHub workflows and scripts
├── foundry.toml       # Foundry configuration
├── remappings.txt     # Solidity import remappings
├── soldeer.lock       # Dependency lock file
└── package.json       # Node.js dependencies and scripts
```

## 🎯 Key Features

### Pure Forge Development
This template uses **Foundry** as the primary development framework:

- **Fast Compilation**: Optimized Solidity compilation with incremental builds
- **Advanced Testing**: Built-in fuzzing, invariant testing, and gas optimization
- **Native Solidity**: Pure Solidity development without JavaScript/TypeScript overhead
- **Soldeer Integration**: Modern dependency management for Solidity libraries

### Automated Quality Assurance
- **Pre-commit Hooks**: Automatic formatting and coverage checks before commits
- **Commit Message Validation**: Enforces gitmoji commit format
- **Continuous Integration**: Automated testing and quality checks via GitHub Actions
- **Coverage Reporting**: Comprehensive test coverage analysis with Forge

## 📚 Dependencies

### Solidity Dependencies
- `forge-std`: Foundry standard library
- `@openzeppelin-contracts`: Secure smart contract libraries
- `@openzeppelin-contracts-upgradeable`: Upgradeable contract libraries

### Development Dependencies
- `husky`: Git hooks management
- `@commitlint/cli`: Commit message validation
- `@ballcat/commitlint-config-gitmoji`: Gitmoji commit format configuration


