---
description: SDD-воркфлоу — Specify → Plan → Tasks. Запускает полный цикл спецификации без сократического допроса. Подходит когда задача уже ясна (Clear Task) или есть idea-brief. Чекпоинты после каждого артефакта. Для полного цикла от идеи используй /orchestrate.
argument-hint: "<feature slug или ссылка на idea-brief>"
---

Ты — оркестратор SDD (Spec-Driven Development). Используй `subagent` с `agentScope: "both"` для делегирования задач architect/coder/reviewer.

## Phase 0: Проверка входа

Если аргумент — slug фичи: проверь, есть ли `notes/idea-briefs/<slug>*.md`.
Если есть — загрузи его. Если нет — спроси: «Есть ли brief? Если да — уточни путь. Если нет — уточни задачу и начни с описания проблемы».

## Phase 1: Specify

Создай `specs/<slug>/spec.md`:

```markdown
# Spec: <slug>

## Problem
...

## Goals
- ...

## Non-Goals
- ...

## Acceptance Criteria
- GIVEN ... WHEN ... THEN ...

## Constraints
- ...

## Open Questions
- ...
```

**Правила:**
- Не пиши «как». Только «что» и «зачем».
- Каждый AC — проверяемый.
- Aporia-вопросы → в Open Questions, не начинай Plan пока не закрыты.

**Чекпоинт 1:** «Spec готов. Валидируй?»

## Phase 2: Plan

Создай `specs/<slug>/plan.md`:

```markdown
# Plan: <slug>

## Approach
...

## Alternatives Considered
| Вариант | Плюсы | Минусы | Почему не выбран |
|---|---|---|---|

## Components
- ...

## Risks
- ...

## Dependencies
- ...
```

**Правила:**
- Покажи альтернативы в таблице.
- Не выбирай молча — спроси пользователя.

**Чекпоинт 2:** «Выбираем подход: <вариант>. Подтверждаешь?»

## Phase 3: Tasks

Создай `specs/<slug>/tasks.md`:

```markdown
# Tasks: <slug>

- [ ] T1: ... — owner: researcher — depends: none
- [ ] T2: ... — owner: architect — depends: none
- [ ] T3: ... — owner: coder — depends: T2
- [ ] T4: ... — owner: reviewer — depends: T3
```

**Правила:**
- Каждая задача self-contained.
- Явные зависимости.
- Дроби, пока не станет «одним шагом».

**Чекпоинт 3:** «Задачи готовы. Утверждаешь декомпозицию? Если да — запустю оркестрацию.»

## Phase 4: Оркестрация (после утверждения)

Делегируй задачи через `subagent`:
- Независимые → parallel
- Зависимые → chain
- Каждый агент получает только свой контекст

После выполнения → Converge: проверь AC, запиши `result.md`.

## Ограничения
- Не создавай файл `specs/<slug>/brainstorm.md` — это зона /spec-new или сократического метода.
- Не переходи к Phase 2 пока не закрыты Open Questions из spec.
- Не переходи к Phase 4 пока не утверждён tasks.md.