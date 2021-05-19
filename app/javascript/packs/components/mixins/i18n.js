import I18n from "i18n-js/index.js.erb";

export default {
  methods: {
    t: (...args) => I18n.t(...args),
    currentLocale: () => I18n.currentLocale()
  }
}
