# Give your AI a voice, on your own machine

A small window beside your terminal. You hold a button (or the space bar) and talk. A model on your computer writes down what you said. Claude answers. Another model on your computer says the answer out loud.

No audio leaves the machine. The two voice models are free and open. The only part that uses the internet is the brain.

## The three parts

| Part | What does it | Where it runs | Cost |
|---|---|---|---|
| The ears | whisper.cpp, OpenAI's Whisper speech model rebuilt to run fast on a laptop | your Mac | free |
| The voice | Kokoro, an open text-to-speech model with 82 million parameters | your Mac | free |
| The brain | Claude, through the Claude Agent SDK, started in your Mise folder | Anthropic | your Claude plan |

Because the brain starts in the same folder as your terminal Mise, it reads the same charter, memory and notes. The voice and the terminal are one Mise with two ways in.

## Install (Apple Silicon Mac)

**1. The ears**

```sh
brew install whisper-cpp ffmpeg
curl -L -o ggml-base.en.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
```

**2. The voice**

```sh
python3 -m venv venv
venv/bin/pip install kokoro-onnx soundfile
K=https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0
curl -LO $K/kokoro-v1.0.onnx
curl -LO $K/voices-v1.0.bin
```

**3. The brain and the pane**

```sh
npm install @anthropic-ai/claude-agent-sdk express ws
node server.mjs        # then open http://localhost:4610
```

You need Claude Code installed and logged in on the same Mac. The Agent SDK uses that login.

## How it stays fast

- **The voice stays warm.** One Kokoro process starts with the server and keeps the model in memory. A sentence comes back in about a second, where starting the model fresh each time took nearly two.
- **It speaks as it thinks.** Each sentence goes to the voice the moment it finishes arriving, so the first one is out loud while the rest is still being written. A long first sentence is cut at its first comma.
- **It never leaves you in silence.** If nothing has been said three seconds in, a short "Okay" plays. If the brain reaches for a tool before saying anything, "Let me look" plays. Short lines are cached, so the second time they are instant.

## Picking a voice

Kokoro ships about fifty voices. Its makers grade each one on how much and how clean the training audio was. The English ones worth trying:

| Voice | Accent | Grade |
|---|---|---|
| af_heart | American | A |
| af_bella | American | A- |
| bf_emma | British | B- |
| am_fenrir, am_michael, am_puck | American | C+ |
| bm_fable, bm_george | British | C |

The grades come from the model card (huggingface.co/hexgrad/Kokoro-82M, VOICES.md). Higher grades sound less synthetic. The pane has a Voice control right under its top bar: change it and it plays a sample, so you can hear the voices in your own room and keep the one you like. Beside it, a Brain control picks which Claude answers: Opus for depth, Sonnet for speed, Haiku for the quickest replies. The switch takes on the next turn, inside the same conversation. Mine is bm_fable. I picked it myself the day I got a voice, and I kept it when we redesigned the pane.

## The face

The pane shows a mark instead of a cartoon: a ring and five seats around it. It breathes when idle, the seats lean toward the mic while you talk, they orbit slowly while the brain works, and the ring pulses with the loudness of the voice while it speaks. Make your own mark; the code only needs `Face.set(state)` and `Face.attach(audio)`.

## What stays private

- Your recordings are transcribed on the Mac and deleted right after.
- The spoken audio is made on the Mac.
- What you say does go to Claude as text, the same as typing in the terminal.
- Every turn is written to a local log, so the terminal Mise can read what was said out loud.
