<template>
  <div :id="`user-${user.id}`">
    <a :href="'/users/' + user.id" class="post-avatar">
      <img :src="user.avatar.small_thumb.url">
    </a>
    <a :href="'/users/' + user.id" class="nick">{{ user.nickname }}</a>
    <span class= "name">{{ user.name }}</span>
  </div>
</template>

<script>
  export default {
    name: 'UserInfo',
    props: ['user'],
  };
</script>

<style scoped>
.nick {
  position: absolute;
  top: 10px;
  font-weight: 600;
  color: black;
}

.name {
  position: absolute;
  top: 30px;
  color: #777;
}
</style>
