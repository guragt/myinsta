<template>
  <div id="app">
    <button type="button" class="btn-stat" @click="showModal">
      <span class='btn-count'>{{ btnCount }}</span> {{ btnText }}
    </button>

    <modal 
      v-show="isModalVisible"
      v-bind:title="btnText"
      v-bind:userId="userId"
      v-bind:listType="listType"
      @close="closeModal"
    ></modal>
  </div>
</template>

<script>
  import Modal from './packs/components/modal.vue';
  
  export default {
    components: {
      Modal
    },
    props: ['btnCount', 'btnText', 'userId', 'listType'],
    data: function () {
      return {
        isModalVisible: false
      }
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
