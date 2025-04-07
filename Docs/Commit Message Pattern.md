## Commit Message Pattern

### **Commit Structure**
Each commit message follows this structured format:

```markdown
<emoji> <type>(<scope>): <short description>

- <Bullet point describing a change>
- <Another bullet point describing another change>
```

### **Commit Types**
| Type      | Description |
|-----------|-------------|
| `feat`    | ✨ Introduces a new feature (corresponds to MINOR in semantic versioning) |
| `fix`     | 🐛 Fixes a bug (corresponds to PATCH in semantic versioning) |
| `docs`    | 📚 Changes related to documentation (e.g., README updates) |
| `style`   | 🎨 Code formatting, linting, or whitespace changes (no code logic changes) |
| `refactor`| ♻️ Code refactoring that does not change functionality (e.g., improving performance, restructuring) |
| `build`   | 🔧 Changes related to the build system or dependencies |
| `test`    | ✅ Adding or updating tests |
| `chore`   | 🔨 Maintenance tasks, configuration updates, or non-code changes |

### **Emoji Reference**
| Emoji  | Meaning |
|--------|---------|
| 🎉  | Initial commit |
| 🔖  | Tagging a new version |
| ✨  | New feature |
| 🐛  | Bug fix |
| 📚  | Documentation changes |
| ✅  | Adding tests |
| 🚧  | Work in progress |
| 🔧  | Configuration files |
| ➖  | Removing a dependency |
| ➕  | Adding a dependency |
| 💥  | Reverting changes |
| ♻️  | Refactoring |
| 🚚  | Moving or renaming files |

### **Example Commit Messages**
#### Feature Addition
```markdown
✨ feat(ui): add dark mode support

- Implement a toggle switch for dark mode.
- Update styles to support light and dark themes.
```

#### Bug Fix
```markdown
🐛 fix(api): resolve authentication timeout issue

- Adjusted token expiration time to prevent early logouts.
- Improved error handling in authentication middleware.
```

#### Documentation Update
```markdown
📚 docs(readme): update installation guide

- Added missing dependency setup steps.
- Clarified version requirements for better compatibility.
```

Following this pattern ensures clear, structured, and meaningful commit messages. 🚀
