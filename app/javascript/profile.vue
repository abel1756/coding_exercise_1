<template>
  <div id="app">
    <v-app>
      <v-app-bar id="profile-nav-bar" color="white">
        <v-tabs>
          <v-tab href="#profile">Profile</v-tab>
          <v-tab-item key="profile" id="profile" v-bind="currentAuthor">
            <v-container id="profile-container">
              <v-row>
                <v-text-field
                  v-model="currentAuthor.first_name"
                  label="First Name"
                  outlined
                  readonly
                ></v-text-field>
              </v-row>
              <v-row>
                <v-text-field
                    v-model="currentAuthor.last_name"
                    label="Last Name"
                    outlined
                    readonly
                ></v-text-field>
              </v-row>
              <v-row>
                <v-text-field
                    v-model="currentAuthor.email"
                    label="Email"
                    outlined
                    readonly
                ></v-text-field>
              </v-row>
            </v-container>
          </v-tab-item>
          <v-tab href="#books">Books</v-tab>
        </v-tabs>
      </v-app-bar>
    </v-app>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      currentAuthor: null,
    }
  },
  mounted() {
    axios.get("http://localhost:3000/profile", { headers: {'Accept': 'application/json'}}).then(response => {
      this.currentAuthor = response.data;
    });
  }
}
</script>

<style scoped>
#profile-nav-bar {
  margin-left: auto;
  margin-top: 5%;
  width: 100%;
  height: 100%;
}

#profile-container {
  margin-left: 10px;
  margin-top: 30px;
  width: 20%;
}
</style>
