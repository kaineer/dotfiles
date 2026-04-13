local DconfTask(username, title, key, value) = {
  name: title,
  become_user: username,
  dconf: {
    key: key,
    value: value,
  },
};

DconfTask
