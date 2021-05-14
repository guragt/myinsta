<template>
  <ul id="relationship-list">
    <li v-for="item in relationships" class="relationship">
      <relationship-item
        v-bind:item="item"
        v-bind:listType="listType"
        v-bind:isCurrentUser="isCurrentUser"
      ></relationship-item>
    </li>
  </ul>
</template>

<script>
  import axios from "axios";
  import RelationshipItem from './relationship_item.vue';

  export default {
    name: 'RelationshipList',
    props: ['userId', 'listType', 'isCurrentUser'],
    components: {
      RelationshipItem
    },
    data: function () {
      return {
        relationships: []
      }
    },
    mounted() {
      axios
        .get(`/users/${this.userId}/${this.listType}`)
        .then(response => (this.relationships = response.data));
  }
  };
</script>

<style scoped>
  .relationship {
    display: list-item;
    position: relative;
    margin: 0;
  }
</style>
