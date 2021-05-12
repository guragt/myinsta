<template>
  <div :id="`item-${item.id}`">
    <div v-if="listType === 'followers'">
      <user-info v-bind:user="item.follower"></user-info>
    </div>
    <div v-else-if="listType === 'following'">
      <user-info v-bind:user="item.followed"></user-info>
    </div>
  </div>
</template>

<script>
  import UserInfo from './user_info.vue';

  export default {
    name: 'RelationshipItem',
    props: ['item', 'listType'],
    components: {
      UserInfo
    },
  };
</script>

<style>
</style>