# Setup Pop!\_OS – Entorno de Desarrollo Completo

Este repositorio contiene un **script automatizado** para configurar un entorno de desarrollo completo en Pop!\_OS (NVIDIA) con:

* Git + SSH
* Python + librerías de IA y backend
* Docker + Docker Compose
* Node.js + NVM + Yarn/Pnpm
* Flutter + Android Studio
* Kotlin + IntelliJ IDEA
* VS Code
* Zsh + Oh My Zsh

---

## ⚠️ Importante – Seguridad

1. **Git global user/email**
   Antes de ejecutar el script, modifica estas líneas en `setup-popos.sh` con tu información o variables genéricas:

   ```bash
   git config --global user.name "TU_NOMBRE"
   git config --global user.email "TU_EMAIL"
   ```

2. **Claves SSH**

   * El script genera tu clave SSH en `~/.ssh/id_ed25519`.
   * **No subas nunca tu carpeta `~/.ssh` ni tu clave privada a GitHub**.
   * Solo se copia la clave pública al portapapeles para añadirla a GitHub/GitLab/Bitbucket.

---

## 💻 Cómo usar el script

1. Clonar el repositorio:

```bash
git clone https://github.com/TU_USUARIO/popos-setup.git
cd popos-setup
```

2. Dar permisos de ejecución al script:

```bash
chmod +x setup-popos.sh
```

3. Ejecutar el script:

```bash
bash setup-popos.sh
```

4. Seguir las instrucciones en pantalla (por ejemplo, copiar la clave SSH).

5. Reinicia la sesión o el equipo para aplicar todos los cambios.

---

## 🔹 Notas

* El script instala software usando `apt` y `flatpak`.
* Revisa la instalación de NVM, Node.js y Flutter en tu terminal después de ejecutar el script.
* Para desarrollo móvil con Flutter, abre Android Studio y configura los **SDKs** según tus necesidades.
* Docker se instala con permisos de usuario; puedes ejecutar contenedores sin `sudo`.

---

## 📌 Recomendación

* Ejecuta este script **solo en una instalación limpia de Pop!\_OS**.
* Personaliza las variables de usuario y correo antes de subir el script a GitHub.
* Mantén tu clave privada de SSH siempre en `~/.ssh` y **nunca la compartas**.
