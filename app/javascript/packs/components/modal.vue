<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <button class="modal-default-button" @click="$emit('close')">x</button>
            <h3>{{ title }}</h3>
          </div>

          <div class="modal-body">
            <relationship-list 
              v-bind:userId="userId"
              v-bind:listType="listType"
            ></relationship-list>
          </div>

        </div>
      </div>
    </div>
  </transition>
</template>

<script>
  import RelationshipList from './relationship_list.vue';

  export default {
    name: 'Modal',
    props: ['title', 'userId', 'listType'],
    components: {
      RelationshipList
    },
    methods: {
      close() {
        this.$emit('close');
      },
    },
  };
</script>

<style scoped>
  .modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: table;
    transition: opacity 0.3s ease;
  }

  .modal-wrapper {
    display: table-cell;
    vertical-align: middle;
  }

  .modal-container {
    width: 450px;
    margin: 0px auto;
    padding: 10px 10px;
    background-color: #fff;
    border-radius: 6px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
    transition: all 0.3s ease;
    font-family: Helvetica, Arial, sans-serif;
  }

  .modal-header {
    padding: 5px;
  }

  .modal-header h3 {
    margin-top: 0;
    text-transform: capitalize;
    font-weight: 600;
    text-align: center;
  }

  .modal-body {
    overflow-y: auto;
    overflow-x: hidden;
    height: 400px;
  }

  .modal-default-button {
    float: right;
    margin-top: -10px;
    margin-right: -10px;
    border: none;
    background: none;
    color: grey;
  }

  .modal-enter {
    opacity: 0;
  }

  .modal-leave-active {
    opacity: 0;
  }

  .modal-enter .modal-container,
  .modal-leave-active .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
  }
</style>
