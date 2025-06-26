for c in agent_1 agent_2; do
  docker exec -i $c bash -c "
    install -d -o ansible -g ansible -m 700 /home/ansible/.ssh &&
    cat >> /home/ansible/.ssh/authorized_keys" < ~/.ssh/id_ed25519.pub
  docker exec $c chown ansible:ansible /home/ansible/.ssh/authorized_keys
  docker exec $c chmod 600 /home/ansible/.ssh/authorized_keys
done
