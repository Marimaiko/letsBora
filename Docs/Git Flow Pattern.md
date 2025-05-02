## Git Flow Guide

### **Overview**
Git Flow is a branching model that organizes development workflows, making collaboration and release management more structured.

### **Branching Model**
Git Flow defines different branches for various purposes:

#### **Main Branches**
| Branch  | Purpose |
|---------|---------|
| `main`  | Production-ready code; contains only stable releases. |
| `develop` | Ongoing development; where new features are merged before release. |

#### **Supporting Branches**
| Branch       | Purpose |
|-------------|---------|
| `feature/*` | New feature development; merged into `develop` when complete. |
| `release/*` | Prepares a new release; allows final bug fixes before merging into `main`. |
| `hotfix/*` | Critical fixes for production issues; merged into `main` and `develop`. |
| `bugfix/*` | Fixes for non-critical issues; merged into `develop`. |

### **Workflow Steps**
#### **Starting a New Feature**
```bash
git checkout develop
git checkout -b feature/feature-name
```

#### **Develop and Commit Changes**
```bash
git add .
git commit -m "✨ feat(feature-name): add new feature"
```

#### **Merge Feature into Develop**
```bash
git checkout develop
git merge feature/feature-name
```

#### **Creating a Release Branch**
```bash
git checkout -b release/version-x.y.z
```

#### **Merge into Main and Tag the Release**
```bash
git checkout main
git merge release/version-x.y.z
git tag -a vX.Y.Z -m "Release version X.Y.Z"
```

#### **Deploy and Clean Up**
```bash
git branch -d release/version-x.y.z
```

Following Git Flow ensures a clean, organized, and scalable development process. 🚀
