FROM archlinux:latest

# 1) Устанавливаем всё нужное
RUN pacman -Sy --noconfirm && \
    pacman -Syu --noconfirm \
      openssh sudo python git nano && \
    pacman -Scc --noconfirm

# 2) Создаём пользователя ansible с паролем без sudo-пароля
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 3) Готовим SSH: ключи демона + папка для authorized_keys
RUN ssh-keygen -A && \
    mkdir -p /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh && \
    chown ansible:ansible /home/ansible/.ssh

# (Опционально) копируем свой публичный ключ:
# COPY id_rsa.pub /home/ansible/.ssh/authorized_keys
# RUN chown ansible:ansible /home/ansible/.ssh/authorized_keys && \
#     chmod 600 /home/ansible/.ssh/authorized_keys

EXPOSE 22               
CMD ["/usr/sbin/sshd", "-D"]
