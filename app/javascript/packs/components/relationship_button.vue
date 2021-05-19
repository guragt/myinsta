<template>
  <span v-if="isDeleted" class="delete-message">
    {{ messageText }}
  </span>
  <span v-else class="follow-button">
    <button class="btn btn-default" @click="deleteRelationship">{{ buttonText }}</button>
  </span>
</template>

<script>
  import axios from "axios";
  import i18n from "./mixins/i18n";

  export default {
    name: 'RelationshipButton',
    mixins: [i18n],
    props: ['itemId', 'listType'],
    data: function () {
      return {
        isDeleted: false
      }
    },

    computed: {
      buttonText: function () {
        return this.listType === 'followers' ? this.t("js.delete") : this.t("js.unfollow")
      },
      messageText: function () {
        return this.listType === 'followers' ? this.t("js.deleted") : this.t("js.unfollowed")
      }
    },

    methods: {
      deleteRelationship() {
        axios.delete(`/relationships/${this.itemId}`);
        this.isDeleted = true;
      }
    }
  }
</script>

<style>
  .delete-message {
    display: inline-block;
    color: grey;
    margin-right: 15px;
    margin-top: 8px;
  }
</style>
