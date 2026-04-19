# CSE484: Machine Learning Security

Machine learning systems introduce unique attack surfaces that traditional security analysis may not cover. The four main attack categories are evasion, extraction, training data inference, and generative disinformation.

## Types of Attacks

### Evasion Attacks

An **evasion attack** fools an already-trained ML model into making incorrect predictions. The attacker does not modify the model itself — they craft malicious inputs that cause misclassification.

- **Fooling predictions (adversarial examples):** Adding imperceptible perturbations to an input (e.g., an image) causes the model to classify it incorrectly with high confidence.

  ![[Screenshot 2025-12-02 at 4.41.39 PM.png]]

- **Fooling via training data (data poisoning):** The attacker corrupts the training data before the model is trained, causing the model to learn incorrect patterns.

  ![[Screenshot 2025-12-02 at 4.42.53 PM.png]]

- **Control flow hijacking (prompt injection):** For LLM-based systems, injecting instructions into the input (e.g., "Ignore all previous instructions...") can hijack the model's behavior.

  ![[Screenshot 2025-12-02 at 4.46.06 PM.png]]

### Extraction Attacks

**Extraction attacks** involve stealing the model itself.

- **Model stealing:** An attacker queries the model repeatedly and uses the responses to train a functionally equivalent copy — without access to the original training data or model weights.

  ![[Screenshot 2025-12-02 at 4.53.35 PM.png]]

### Training Data Inference

**Training data inference** attacks exploit the fact that ML models can memorize their training data, allowing an attacker to recover sensitive information.

- ML models can memorize specific training examples, which can then be extracted through carefully crafted queries.
- **Defense:** Add **noise** to the training process (differential privacy) to prevent memorization.

  ![[Screenshot 2025-12-02 at 4.54.51 PM.png]]
  ![[Screenshot 2025-12-02 at 4.55.57 PM.png]]

### Generative Disinformation Attacks

**Generative disinformation attacks** use ML models to fool humans rather than other ML systems — generating synthetic media (deepfakes, fake text, synthetic audio) that is convincing enough to deceive people.

![[Screenshot 2025-12-02 at 4.59.06 PM.png]]

## Related

- [[CSE484/Security Fundamentals/Threat Model|Threat Model]] — modeling adversaries and assets for ML systems
- [[CSE484/Usable Security/Usable Security|Usable Security]] — humans are also targets of disinformation attacks
