<template>
  <div :id="`item-${item.id}`">
    <span v-if="listType === 'followers'">
      <user-info v-bind:user="item.follower"></user-info>
    </span>
    <span v-else-if="listType === 'following'">
      <user-info v-bind:user="item.followed"></user-info>
    </span>
    <span v-if="isCurrentUser" class="relation">
      <relationship-button
        v-bind:listType="listType"
        v-bind:itemId="item.id"
      ></relationship-button>
    </span>
  </div>
</template>

<script>
  import UserInfo from './user_info.vue';
  import RelationshipButton from './relationship_button.vue';

  export default {
    name: 'RelationshipItem',
    props: ['item', 'listType', 'isCurrentUser'],
    components: {
      UserInfo,
      RelationshipButton
    },
  };
</script>

<style>
.relation {
  float: right;
  margin-top: 13px;
}
</style>
