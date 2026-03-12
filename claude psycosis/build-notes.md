# Psycosis — Claude's Build Notes

Detailed log of everything built, every decision made, and why.

---

## Project Overview

**App:** Psycosis — a rich text document/writing app (Google Docs / Word style)
**Platforms:** macOS, iPhone, iPad (all three — one codebase)
**Framework:** SwiftUI
**Owner:** Abdallah (Nollin)

---

## App Architecture — How the Pieces Fit Together

### WindowGroup
The outermost container in `psycosisApp.swift`. Tells SwiftUI what to show when the app launches. On Mac it creates a resizable window. On iPhone/iPad it fills the screen. One `WindowGroup` = all three platforms handled automatically.

```swift
WindowGroup {
    MainView()
}
```

### Why We Switched from DocumentGroup to WindowGroup
Xcode's Document App template uses `DocumentGroup` — that opens each document in its own separate window (like TextEdit). Our mockup shows a single window with a sidebar listing all documents (like Notion or Bear). That required switching to `WindowGroup` and building custom document management.

### NavigationSplitView — The Core Layout
The backbone of the whole app. Splits the screen into two panels:
- **Left** → sidebar (document list)
- **Right** → detail (the editor)

```swift
NavigationSplitView {
    SidebarView()    // left panel
} detail: {
    EditorView()     // right panel
}
```

**Platform behavior — automatic, no extra code:**
- Mac + iPad landscape → both panels visible side by side
- iPhone + iPad portrait → sidebar collapses, back button appears

### Why Three Separate Files?
Each file has ONE job:
| File | Job |
|------|-----|
| `psycosisApp.swift` | Entry point — launches the app, sets up WindowGroup |
| `MainView.swift` | Layout only — sets up the NavigationSplitView split |
| `SidebarView.swift` | Left panel — document list, recents, iCloud, new doc button |
| `EditorView.swift` | Right panel — writing canvas, toolbar, status bar |
| `Splashview.swift` | Splash screen — logo on gray, shown on first launch |

If something breaks in the sidebar → go to `SidebarView.swift`. If the editor has a bug → go to `EditorView.swift`. Clean, organized, easy to find things.

---

## File Reference

### psycosisApp.swift
Entry point. `@main` means Swift starts here. Contains `WindowGroup` which tells the app what to show.

### Splashview.swift
Logo centered on `systemGray4` background. `ZStack` layers the background color behind the image. `ignoresSafeArea()` makes the color fill the entire screen including notch/corners. Will be shown as a timed intro before transitioning to `MainView`.

### MainView.swift
Only contains the `NavigationSplitView`. Doesn't know anything about documents or the editor — just handles the left/right layout split.

### SidebarView.swift
Will contain: Recents section, iCloud section, New Document button at bottom. Currently placeholder.

### EditorView.swift
Will contain: white document page, formatting toolbar (Bold/Italic/Underline/styles), status bar (word count, save status, iCloud indicator). Currently placeholder.

### psycosisDocument.swift
The data model for a single document — how a document is read from and written to disk. Still useful even though we dropped DocumentGroup. Will be wired in when we build the document save/load system.

---

## Build Order

| Step | Feature | Status |
|------|---------|--------|
| 1 | Understand existing template | ✅ Done |
| 2 | Switch DocumentGroup → WindowGroup | ✅ Done |
| 3 | Splash screen with logo | ✅ Done |
| 4 | MainView — NavigationSplitView skeleton | ✅ Done |
| 5 | SidebarView — Recents + iCloud list | ✅ Done |
| 6 | EditorView — document page + toolbar | ✅ Done |
| 7 | Splash → MainView transition | ⬜ Pending |
| 8 | Rich text formatting (bold, italic, underline) | ⬜ Pending |
| 9 | Document model — create, save, load | ⬜ Pending |
| 10 | Status bar (word count, save status, iCloud) | ⬜ Pending |
| 11 | Styling + custom aesthetic | ⬜ Pending |
| 12 | Platform-specific tweaks (iPhone/iPad/Mac) | ⬜ Pending |
| 13 | iCloud sync | ⬜ Pending |

---

## Session Log

### Session 2 — Mar 11, 2026
- Built SidebarView — List with RECENTS + ICLOUD sections, New Document button pinned to bottom using VStack
- Built DocumentRowView — reusable row with doc icon, title, date. Separate file so all rows update from one place
- Built EditorView — VStack of ToolbarView + ScrollView (white page) + StatusBarView
- Built ToolbarView — HStack with Body style Menu, B/I/U buttons, Divider, Spacer
- Built StatusBarView — word count computed from text.split(separator:" ").count, Saved + iCloud indicators
- Added #Preview to ToolbarView and StatusBarView (StatusBarView preview needs sample text passed in)
- Bug caught: struct renamed to StatusBarView (capital B) but EditorView still called StatusbarView (lowercase b) — fixed by updating EditorView reference
- Key concept learned: Swift is case sensitive — struct name and every reference to it must match exactly

### Key Concepts from This Session
- **@State** — marks a value as changeable. When it changes, SwiftUI redraws the view. The `text` in EditorView is `@State` because the user typing updates it constantly
- **$text (binding)** — the `$` means "two-way connection." TextEditor can both read AND write to `text`. Without `$` it would be read-only
- **Computed property** — `var wordCount: Int { ... }` runs code every time it's accessed. No need to manually update it — SwiftUI calls it automatically when `text` changes
- **VStack(spacing: 0)** — stacks views vertically with no gap between them. Used in EditorView so toolbar, page, and status bar sit flush against each other
- **Preview with parameters** — if a view requires input (`let text: String`), the #Preview block must supply it: `StatusBarView(text: "sample")`

### Session 1 — Mar 11, 2026
- Project created with Xcode Document App template
- All three platforms targeted: macOS, iOS, iPadOS
- Read through all existing files — solid foundation, nothing to redo
- Reviewed lowfi mockups — confirmed design direction:
  - Splash screen: logo centered on gray background, orange border
  - Main app: NavigationSplitView — left sidebar (Recents + iCloud + New Doc button), right editor (white page, formatting toolbar, status bar)
- Switched DocumentGroup → WindowGroup in psycosisApp.swift
- Created Splashview.swift — logo centered on systemGray4, 200x200 frame
- Confirmed: rich text (Google Docs / Word style), not plain text
- Created MainView.swift — NavigationSplitView with SidebarView + EditorView
- Created SidebarView.swift — placeholder
- Created EditorView.swift — placeholder
- App name: Psycosis. Logo asset: "LOGO" in Assets.xcassets

---

## Platform Notes

### What works automatically:
- NavigationSplitView collapses sidebar on iPhone/iPad portrait automatically
- SwiftUI adapts font sizes and spacing per platform
- WindowGroup creates the right window type per platform

### What needs platform-specific attention later:
- Toolbar layout (macOS toolbar vs iOS navigation bar)
- Keyboard shortcuts (macOS only)
- Font sizes for touch targets (iPhone/iPad)

---

## Questions Resolved
- ✅ Plain text or rich text → Rich text (Word/Google Docs style)
- ✅ Single window with sidebar → confirmed from mockup
- ✅ App name → Psycosis
- ✅ DocumentGroup vs WindowGroup → WindowGroup + custom sidebar
