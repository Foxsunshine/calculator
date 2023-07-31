<script >
import Decimal from 'decimal.js'

const MAX_LENGTH = 10_000_000_000_000_000_000n;

export default {
  data() {
    return {
      result: '',
      currentInput:'0',
      operator:'',
      ifShowResult:false,
      ifAvaliable:true,
      ifShowReset:false,

      shouldShake:false,
      buttonLeft:'5px',
      theme: 'theme-1',
      equationLogs: [],
      id:'',
    }
  },
  methods: {

    reset(){
      this.result = ''
      this.currentInput='0'
      this.operator=''
      this.ifShowResult=false
      this.ifAvaliable=true
      this.ifShowReset=false
    },
    showResetMsg(){
      this.ifShowReset=true
    },

    addNumber(e){
      if(!this.ifAvaliable){
        this.showResetMsg()
        this.shake()
      }
      let currentInput = e.target.textContent
      if(this.currentInput == '0'){
        this.currentInput = currentInput
      }else if(this.ifAvaliable){
        this.currentInput += currentInput
      }
      let length=this.currentInput.length
      if(length>=17){
          this.ifAvaliable=false
      }
      this.ifShowResult=false
    },

    operate(e){
      if(!this.ifAvaliable){
        this.showResetMsg()
        this.shake()
      }
      if(this.operator=='')
        this.operator = e.target.textContent
       if(this.result==''){
        this.result = this.currentInput
        this.ifFirstInput=false
        this.ifShowResult=true
        this.currentInput='0'
      }else{
        this.equal()
      }
      this.operator = e.target.textContent
    },

    equal(){
      if(!this.ifAvaliable){
        this.showResetMsg()
        this.shake()
      }
      const firstOperand = new Decimal(this.result);
      const secondOperand = new Decimal(this.currentInput);

      let calculationResult = new Decimal(0);
        
        if(this.operator == '+')
          calculationResult =firstOperand.plus(secondOperand)
        if(this.operator == '-')
          calculationResult =firstOperand.minus(secondOperand)
        if(this.operator == '/')
        {
          if(secondOperand.eq(0)){
            this.ifAvaliable = false
          }else{
            calculationResult =firstOperand.dividedBy(secondOperand)
          }
        }
        if(this.operator == 'x'){
          calculationResult =firstOperand.times(secondOperand)
        }
        if(this.ifAvaliable){
          this.result=calculationResult.toString()
        }

        if(calculationResult.gte(new Decimal(MAX_LENGTH))){
          this.ifAvaliable = false
        }

        this.result = calculationResult.toString();
        this.ifShowResult=true
        this.currentInput='0'
    },
    del(){
      if(!this.ifAvaliable){
        this.showResetMsg()
        this.shake()
      }
      if(this.currentInput.length==1){
        this.currentInput='0'
      }else{
        this.currentInput=this.currentInput.substring(0,this.currentInput.length-1)}
    },
    toggleButton(){
      this.buttonLeft = this.buttonLeft === '5px' ? '18px' :'5px';
      this.theme = this.theme === 'theme-1' ? 'theme-2' : 'theme-1';  // 切换主题
    },
    updateBodyClass() {
      // 移除旧的主题类名，添加新的主题类名
      document.body.classList.remove('theme-1', 'theme-2');
      document.body.classList.add(this.theme);
    },
    shake() {
      this.shouldShake = true;
      setTimeout(() => {
        this.shouldShake = false;
      }, 1000);
    },
    check() {
      fetch(`http://localhost:8080/api/getequatationlogbyid/${this.id}`)
        .then((res) => {
          if (!res.ok) {
            throw new Error("ネットワークエラー。APIを呼び出せませんでした。");
          }
          return res.json();
        })
        .then((jsonData) => {
          this.equationLogs = [jsonData]; // APIが1つの従業員オブジェクトを返す場合。複数の従業員を取得する場合はこの箇所を変更してください。
          console.log(this.equationLogs);
        })
        .catch((err) => console.error(err));

        console.log(this.equationLogs[0])
        console.log(this.equationLogs[0].id)
        console.log(this.equationLogs[0].personalInformation)
      
  },
  },
  mounted() {
    this.updateBodyClass();
  },
  watch: {
    theme() {
      this.updateBodyClass();
    },
  }
}

</script>

<template>
  <div class="whole-container">
  <div class="calc-container">
    <div class="user-container">
      <div class="input-container"><h4>入力:<input v-model="id"></h4></div>
      <div class="check-container"><button @click="check" class="check">確認</button></div>
    </div>
    <div class="header">
      <h4 class="logo">calc</h4>
      <div class="theme-container">
        <h5 class="theme">THEME</h5>
        <div class="toggle-container">
          <button class="theme-button" :style="{left:buttonLeft}" @click="toggleButton"></button>
        </div>
      </div>
    </div>
    <div class="result-container">
      <h3 v-if="ifShowResult && ifAvaliable" id="result" class="result">{{result}}</h3> 
      <h3 v-else-if="!ifShowResult && ifAvaliable" id="result" class="result">{{currentInput}}</h3>
      <h3 v-else id="result" class="limited-msg">有効数字ではない</h3> 
      <h6 v-if="ifShowReset" class="reset-msg" :class="{ shake: shouldShake }" >リセットしてください</h6>
    </div>
    <div class="operater-container">
      <div class="row">
        <button @click="addNumber" class="number-button">7</button>
        <button @click="addNumber" class="number-button">8</button>
        <button @click="addNumber" class="number-button">9</button>
        <button @click="del" class="number-button del-button">DEL</button>
      </div>
      <div class="row">
        <button @click="addNumber" class="number-button">4</button>
        <button @click="addNumber" class="number-button">5</button>
        <button @click="addNumber" class="number-button">6</button>
        <button @click="operate" class="number-button">+</button>
      </div>
      <div class="row">
        <button @click="addNumber" class="number-button">1</button>
        <button @click="addNumber" class="number-button">2</button>
        <button @click="addNumber" class="number-button">3</button>
        <button @click="operate" class="number-button">-</button>
      </div>
      <div class="row">
        <button @click="addNumber" class="number-button">.</button>
        <button @click="addNumber" class="number-button">0</button>
        <button @click="operate" class="number-button">/</button>
        <button @click="operate" class="number-button">x</button>
      </div>
      <div class="row">
        <button @click="reset" class="number-button reset-button">RESET</button>
        <button @click="equal" class="number-button equal-button">=</button>
      </div>
    </div>
  </div>
  <div class="history-container">
       <!--
        <div class="history-msg">
          <div class="history-msg-data">
              <span class="time">2023-10-10 10:10:10</span>
              <span>ジャンチェン : <span>1 + 1 = </span><span>2</span> </span>
          </div>

        </div>-->

        <div v-for="equationLog in equationLogs" :key="equationLog.id">
          <div class="history-msg">
            <div class="history-msg-data">
              <span class="time">{{ equationLog.summit_date }}</span>
              <span>{{ equationLog.personalInformation.name }}: <span>{{ equationLog.equation }}</span><span>{{ equationLog.result }}</span> </span>
              </div>
            </div>
        </div> 
      
  </div>
  </div>

</template>

<style scoped>
.whole-container{
  display: flex;
}
.history-container{
  display: flex;
  padding-top: 1rem;
  padding-left: 1rem;
  width: 450px;
  max-height: 600px;
  background-color: var(--screen-background-color);
  border-radius: 10px; 
}
.history-msg{
  margin:0 0.5rem;
  font-size: 13px;
  opacity: 0.7;
}
.history-msg-data{
  display: flex;
  flex-direction: column;
  margin-bottom: 0.5rem;
}
.time{
  font-size: 10px !important;
}

</style>
