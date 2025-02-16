# Branching Strategy

## Overview
This document outlines the branching strategy for repository.

## Branch Types

Below are the different branch types which is part of the **Gitflow** workflow:

### 1. **Main (Production) Branch** (`main`)
- The `main` branch is the **production-ready** branch. It always reflects the latest stable release.
- Code in `main` should be deployable at all times.
- Merges to `main` are only made from release or hotfix branches after proper testing.
- The branch name can be either `main` or `master` 

### 2. **Development Branch** (`develop`)
- The `develop` branch contains the **latest development changes**.
- All feature and bug fix branches are merged into `develop`.
- This branch is used to prepare the next release, and it should always be in a working state.
- **Feature branches** should be merged into `develop` after completion and testing.

### 3. **Feature Branches** (`feature/*`)
- Feature branches are used for developing new features or functionality.
- Branch from `develop` and follow the naming convention `feature/{feature-name}`.
- Merge feature branches back into `develop` once the feature is completed and tested.
- These branches should not be directly merged into `main` or `release`.

### 4. **Release Branches** (`release/*`)
- Release branches are used to prepare for a new production release.
- Once `develop` has enough features for a release, create a `release` branch.
- The release branch allows for minor bug fixes, documentation generation, and preparation for the final release.
- After testing, the release branch will be merged into both `main` and `develop`.
- Naming convention: `release/{version}` (e.g., `release/1.0.0`).

### 5. **Hotfix Branches** (`hotfix/*`)
- Hotfix branches are created for critical fixes that need to be applied to production immediately.
- These branches are created from `main`, and once the fix is complete, they are merged back into both `main` and `develop`.
- Naming convention: `hotfix/{issue-name}` (e.g., `hotfix/critical-bug`).
