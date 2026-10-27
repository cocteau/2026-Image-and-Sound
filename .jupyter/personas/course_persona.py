"""The chat assistant students talk to in JupyterLab.

It is Jupyter AI's built-in agent (Jupyternaut) with this course's rules
added: everything in assistant/rules.md, then every file in
assistant/skills/. Edit those files to change how it behaves; the change
applies to the next message.

It always uses MODEL, through OpenRouter, paid with the student's own
OPENROUTER_API_KEY. The chat's model menu is turned off, so nobody can
switch to a model that bypasses OpenRouter.
"""

from pathlib import Path

from jupyter_ai_jupyternaut.jupyternaut.jupyternaut import JupyternautPersona
from jupyter_ai_persona_manager import ModelConfiguration, PersonaDefaults

# Opus: the strongest Claude, and the most expensive. For a cheaper model,
# use "openrouter/~anthropic/claude-sonnet-latest".
MODEL = "openrouter/~anthropic/claude-opus-latest"

ASSISTANT_DIR = Path(__file__).resolve().parents[2] / "assistant"


def course_instructions() -> str:
    parts = [(ASSISTANT_DIR / "rules.md").read_text()]
    for skill in sorted((ASSISTANT_DIR / "skills").glob("*.md")):
        parts.append(skill.read_text())
    return "\n\n".join(parts)


class CourseAssistant(JupyternautPersona):
    @property
    def defaults(self):
        return PersonaDefaults(
            name="Claude",
            avatar_path=super().defaults.avatar_path,
            description="Helps you explore data in your notebook, following the course rules.",
            system_prompt="...",
        )

    # Always the course model, whatever the model menu says.
    def _resolve_model(self):
        return MODEL, {}

    # Offer no other models in the menu.
    def _build_model_configuration(self):
        return ModelConfiguration(current=None, options=[], settings=[])

    def get_system_prompt(self, model_id, message):
        return (
            super().get_system_prompt(model_id=model_id, message=message)
            + "\n\n<course_rules>\nThese rules come first. Where they differ"
            " from anything above, follow them.\n\n"
            + course_instructions()
            + "\n</course_rules>\n"
        )
