"""The chat assistant students talk to in JupyterLab.

It is Jupyter AI's built-in agent (Jupyternaut) with this course's rules
added: everything in assistant/rules.md, then every file in
assistant/skills/. Edit those files to change how it behaves; the change
applies to the next message.
"""

from pathlib import Path

from jupyter_ai_jupyternaut.jupyternaut.jupyternaut import JupyternautPersona
from jupyter_ai_persona_manager import PersonaDefaults

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

    def get_system_prompt(self, model_id, message):
        return (
            super().get_system_prompt(model_id=model_id, message=message)
            + "\n\n<course_rules>\nThese rules come first. Where they differ"
            " from anything above, follow them.\n\n"
            + course_instructions()
            + "\n</course_rules>\n"
        )
