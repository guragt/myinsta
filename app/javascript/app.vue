<template>
  <div id="app">
    <button type="button" class="btn-stat" @click="showModal">
      <span class='btn-count'>{{ btnCount }}</span> {{ btnText }}
    </button>

    <modal 
      v-show="isModalVisible"
      :userId="userId"
      :listType="listType"
      :isCurrentUser="isCurrentUser"
      @close="closeModal"
    ></modal>
  </div>
</template>

<script>
  import Modal from './packs/components/modal.vue';
  import i18n from "./packs/components/mixins/i18n";
  
  export default {
    props: ['btnCount', 'userId', 'listType', 'isCurrentUser'],
    mixins: [i18n],

    components: {
      Modal
    },

    data: function () {
      return {
        isModalVisible: false
      }
    },

    computed: {
      btnText: function () {
        return this.listType === 'followers' ? this.t("js.followers", { count: this.btnCount }) : this.t("js.following")
      },
    },

    methods: {
      showModal() {
        this.isModalVisible = true;
      },
      closeModal() {
        this.isModalVisible = false;
      }
    }
  }
</script>

<style scoped>
  #app {
    display: inline;
  }

  p {
    font-size: 2em;
    text-align: center;
  }

  .btn-stat {
    border: none;
    background: none;
    padding: 0;
    color: black;
  }

  .btn-count {
    font-weight: 600;
  }
</style>
