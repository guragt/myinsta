import I18n from "i18n-js";

export default {
  methods: {
    t: (...args) => I18n.t(...args),
    currentLocale: () => I18n.currentLocale()
  }
}