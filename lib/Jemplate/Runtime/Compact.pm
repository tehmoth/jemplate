package Jemplate::Runtime::Compact;
use strict;
use warnings;

sub main { return &kernel }
sub kernel {
    <<'...';
if(typeof Jemplate=="undefined"){var Jemplate=function(){this.init.apply(this,arguments)}}Jemplate.VERSION="0.22";Jemplate.process=function(){var A=new Jemplate(Jemplate.prototype.config);return A.process.apply(A,arguments)};(function(){if(!Jemplate.templateMap){Jemplate.templateMap={}}var proto=Jemplate.prototype={};proto.config={AUTO_RESET:true,BLOCKS:{},CONTEXT:null,DEBUG_UNDEF:false,DEFAULT:null,ERROR:null,EVAL_JAVASCRIPT:false,GLOBAL:true,SCOPE:this,FILTERS:{},INCLUDE_PATH:[""],INTERPOLATE:false,OUTPUT:null,PLUGINS:{},POST_PROCESS:[],PRE_PROCESS:[],PROCESS:null,RECURSION:false,STASH:null,TOLERANT:null,VARIABLES:{},WRAPPER:[]};proto.defaults={AUTO_RESET:true,BLOCKS:{},CONTEXT:null,DEBUG_UNDEF:false,DEFAULT:null,ERROR:null,EVAL_JAVASCRIPT:false,GLOBAL:true,SCOPE:this,INCLUDE_PATH:[""],INTERPOLATE:false,OUTPUT:null,PLUGINS:{},POST_PROCESS:[],PRE_PROCESS:[],PROCESS:null,RECURSION:false,STASH:null,TOLERANT:null,VARIABLES:{},WRAPPER:[]};Jemplate.init=function(config){Jemplate.prototype.config=config||{};for(var i in Jemplate.prototype.defaults){if(typeof Jemplate.prototype.config[i]=="undefined"){Jemplate.prototype.config[i]=Jemplate.prototype.defaults[i]}}};proto.init=function(config){this.config=config||{};for(var i in Jemplate.prototype.defaults){if(typeof this.config[i]=="undefined"){this.config[i]=Jemplate.prototype.defaults[i]}}};proto.process=function(template,data,output){var context=this.config.CONTEXT||new Jemplate.Context();context.config=this.config;context.stash=new Jemplate.Stash(this.config.STASH,this.config);context.__filter__=new Jemplate.Filter();context.__filter__.config=this.config;context.__plugin__=new Jemplate.Plugin();context.__plugin__.config=this.config;var result;var proc=function(input){try{if(typeof context.config.PRE_PROCESS=="string"){context.config.PRE_PROCESS=[context.config.PRE_PROCESS]}for(var i=0;i<context.config.PRE_PROCESS.length;i++){context.process(context.config.PRE_PROCESS[i])}result=context.process(template,input);if(typeof context.config.POST_PROCESS=="string"){context.config.PRE_PROCESS=[context.config.POST_PROCESS]}for(i=0;i<context.config.POST_PROCESS.length;i++){context.process(context.config.POST_PROCESS[i])}}catch(e){if(!String(e).match(/Jemplate\.STOP\n/)){throw (e)}result=e.toString().replace(/Jemplate\.STOP\n/,"")}if(typeof output=="undefined"){return result}if(typeof output=="function"){output(result);return null}if(typeof (output)=="string"||output instanceof String){if(output.match(/^#[\w\-]+$/)){var id=output.replace(/^#/,"");var element=document.getElementById(id);if(typeof element=="undefined"){throw ('No element found with id="'+id+'"')}element.innerHTML=result;return null}}else{output.innerHTML=result;return null}throw ("Invalid arguments in call to Jemplate.process");return 1};if(typeof data=="function"){data=data()}else{if(typeof data=="string"){var url=data;Jemplate.Ajax.processGet(url,function(data){proc(data)});return null}}return proc(data)};if(typeof Jemplate.Context=="undefined"){Jemplate.Context=function(){}}proto=Jemplate.Context.prototype;proto.include=function(template,args){return this.process(template,args,true)};proto.process=function(template,args,localise){if(localise){this.stash.clone(args)}else{this.stash.update(args)}var func=Jemplate.templateMap[template];if(typeof func=="undefined"){throw ('No Jemplate template named "'+template+'" available')}var output=func(this);if(localise){this.stash.declone()}return output};proto.set_error=function(error,output){this._error=[error,output];return error};proto.plugin=function(name,args){if(typeof name=="undefined"){throw"Unknown plugin name ':"+name+"'"}var func=eval(name);return new func(this,args)};proto.filter=function(text,name,args){if(name=="null"){name="null_filter"}if(typeof this.__filter__.filters[name]=="function"){return this.__filter__.filters[name](text,args,this)}else{throw"Unknown filter name ':"+name+"'"}};if(typeof Jemplate.Plugin=="undefined"){Jemplate.Plugin=function(){}}proto=Jemplate.Plugin.prototype;proto.plugins={};if(typeof Jemplate.Filter=="undefined"){Jemplate.Filter=function(){}}proto=Jemplate.Filter.prototype;proto.filters={};proto.filters.null_filter=function(text){return""};proto.filters.upper=function(text){return text.toUpperCase()};proto.filters.lower=function(text){return text.toLowerCase()};proto.filters.ucfirst=function(text){var first=text.charAt(0);var rest=text.substr(1);return first.toUpperCase()+rest};proto.filters.lcfirst=function(text){var first=text.charAt(0);var rest=text.substr(1);return first.toLowerCase()+rest};proto.filters.trim=function(text){return text.replace(/^\s+/g,"").replace(/\s+$/g,"")};proto.filters.collapse=function(text){return text.replace(/^\s+/g,"").replace(/\s+$/g,"").replace(/\s+/," ")};proto.filters.html=function(text){text=text.replace(/&/g,"&amp;");text=text.replace(/</g,"&lt;");text=text.replace(/>/g,"&gt;");text=text.replace(/"/g,"&quot;");return text};proto.filters.html_para=function(text){var lines=text.split(/(?:\r?\n){2,}/);return"<p>\n"+lines.join("\n</p>\n\n<p>\n")+"</p>\n"};proto.filters.html_break=function(text){return text.replace(/(\r?\n){2,}/g,"$1<br />$1<br />$1")};proto.filters.html_line_break=function(text){return text.replace(/(\r?\n)/g,"$1<br />$1")};proto.filters.uri=function(text){return encodeURIComponent(text)};proto.filters.url=function(text){return encodeURI(text)};proto.filters.indent=function(text,args){var pad=args[0];if(!text){return null}if(typeof pad=="undefined"){pad=4}var finalpad="";if(typeof pad=="number"||String(pad).match(/^\d$/)){for(var i=0;i<pad;i++){finalpad+=" "}}else{finalpad=pad}var output=text.replace(/^/gm,finalpad);return output};proto.filters.truncate=function(text,args){var len=args[0];if(!text){return null}if(!len){len=32}if(text.length<len){return text}var newlen=len-3;return text.substr(0,newlen)+"..."};proto.filters.repeat=function(text,iter){if(!text){return null}if(!iter||iter==0){iter=1}if(iter==1){return text}var output=text;for(var i=1;i<iter;i++){output+=text}return output};proto.filters.replace=function(text,args){if(!text){return null}var re_search=args[0];var text_replace=args[1];if(!re_search){re_search=""}if(!text_replace){text_replace=""}var re=new RegExp(re_search,"g");return text.replace(re,text_replace)};if(typeof Jemplate.Stash=="undefined"){Jemplate.Stash=function(stash,config){this.__config__=config;this.data={GLOBAL:this.__config__.SCOPE};this.LOCAL_ANCHOR={};this.data.LOCAL=this.LOCAL_ANCHOR;this.update(stash)}}proto=Jemplate.Stash.prototype;proto.clone=function(args){var data=this.data;this.data={GLOBAL:this.__config__.SCOPE};this.data.LOCAL=this.LOCAL_ANCHOR;this.update(data);this.update(args);this.data._PARENT=data};proto.declone=function(args){this.data=this.data._PARENT||this.data};proto.update=function(args){if(typeof args=="undefined"){return }for(var key in args){if(key!="GLOBAL"&&key!="LOCAL"){this.set(key,args[key])}}};proto.get=function(ident,args){var root=this.data;var value;if((ident instanceof Array)||(typeof ident=="string"&&/\./.test(ident))){if(typeof ident=="string"){ident=ident.split(".");var newIdent=[];for(var i=0;i<ident.length;i++){newIdent.push(ident.replace(/\(.*$/,""));newIdent.push(0)}ident=newIdent}for(var i=0;i<ident.length;i+=2){var dotopArgs=ident.slice(i,i+2);dotopArgs.unshift(root);value=this._dotop.apply(this,dotopArgs);if(typeof value=="undefined"){break}root=value}}else{value=this._dotop(root,ident,args)}if(typeof value=="undefined"||value==null){if(this.__config__.DEBUG_UNDEF){throw ("undefined value found while using DEBUG_UNDEF")}value=""}return value};proto.set=function(ident,value,set_default){var root,result,error;root=this.data;while(true){if((ident instanceof Array)||(typeof ident=="string"&&/\./.test(ident))){if(typeof ident=="string"){ident=ident.split(".");var newIdent=[];for(var i=0;i<ident.length;i++){newIdent.push(ident.replace(/\(.*$/,""));newIdent.push(0)}ident=newIdent}for(var i=0;i<ident.length-2;i+=2){var dotopArgs=ident.slice(i,i+2);dotopArgs.unshift(root);dotopArgs.push(1);result=this._dotop.apply(this,dotopArgs);if(typeof value=="undefined"){break}root=result}var assignArgs=ident.slice(ident.length-2,ident.length);assignArgs.unshift(root);assignArgs.push(value);assignArgs.push(set_default);result=this._assign.apply(this,assignArgs)}else{result=this._assign(root,ident,0,value,set_default)}break}return(typeof result!="undefined")?result:""};proto._dotop=function(root,item,args,lvalue){if(root==this.LOCAL_ANCHOR){root=this.data}var atroot=root==this.data;var value,result=undefined;var is_function_call=args instanceof Array;args=args||[];if(typeof root=="undefined"||typeof item=="undefined"||typeof item=="string"&&item.match(/^[\._]/)){return undefined}if(atroot||(root instanceof Object&&!(root instanceof Array))||root==this.data.GLOBAL){if(typeof root[item]!="undefined"&&root[item]!=null&&(!is_function_call||!this.hash_functions[item])){if(typeof root[item]=="function"){result=root[item].apply(root,args)}else{return root[item]}}else{if(lvalue){return root[item]={}}else{if(this.hash_functions[item]&&!atroot||item=="import"){args.unshift(root);result=this.hash_functions[item].apply(this,args)}else{if(item instanceof Array){result={};for(var i=0;i<item.length;i++){result[item[i]]=root[item[i]]}return result}}}}}else{if(root instanceof Array){if(this.list_functions[item]){args.unshift(root);result=this.list_functions[item].apply(this,args)}else{if(typeof item=="string"&&/^-?\d+$/.test(item)||typeof item=="number"){if(typeof root[item]!="function"){return root[item]}result=root[item].apply(this,args)}else{if(item instanceof Array){for(var i=0;i<item.length;i++){result.push(root[item[i]])}return result}}}}else{if(this.string_functions[item]&&!lvalue){args.unshift(root);result=this.string_functions[item].apply(this,args)}else{if(this.list_functions[item]&&!lvalue){args.unshift([root]);result=this.list_functions[item].apply(this,args)}else{result=undefined}}}}if(result instanceof Array){if(typeof result[0]=="undefined"&&typeof result[1]!="undefined"){throw result[1]}}return result};proto._assign=function(root,item,args,value,set_default){var atroot=root==this.data;var result;args=args||[];if(typeof root=="undefined"||typeof item=="undefined"||typeof item=="string"&&item.match(/^[\._]/)){return undefined}if(atroot||root.constructor==Object||root==this.data.GLOBAL){if(root==this.LOCAL_ANCHOR){root=this.data}if(!(set_default&&typeof root[item]!="undefined")){if(atroot&&item=="GLOBAL"){throw"Attempt to modify GLOBAL access modifier"}if(atroot&&item=="LOCAL"){throw"Attempt to modify LOCAL access modifier"}return root[item]=value}}else{if((root instanceof Array)&&(typeof item=="string"&&/^-?\d+$/.test(item)||typeof item=="number")){if(!(set_default&&typeof root[item]!="undefined")){return root[item]=value}}else{if((root.constructor!=Object)&&(root instanceof Object)){try{result=root[item].apply(root,args)}catch(e){}}else{throw"dont know how to assign to ["+root+"."+item+"]"}}}return undefined};proto.string_functions={};proto.string_functions["typeof"]=function(value){return typeof value};proto.string_functions.chunk=function(string,size){var list=new Array();if(!size){size=1}if(size<0){size=0-size;for(var i=string.length-size;i>=0;i=i-size){list.unshift(string.substr(i,size))}if(string.length%size){list.unshift(string.substr(0,string.length%size))}}else{for(i=0;i<string.length;i=i+size){list.push(string.substr(i,size))}}return list};proto.string_functions.defined=function(string){return 1};proto.string_functions.hash=function(string){return{"value":string}};proto.string_functions.length=function(string){return string.length};proto.string_functions.list=function(string){return[string]};proto.string_functions.match=function(string,re,modifiers){var regexp=new RegExp(re,modifiers==undefined?"g":modifiers);var list=string.match(regexp);return list};proto.string_functions.repeat=function(string,args){var n=args||1;var output="";for(var i=0;i<n;i++){output+=string}return output};proto.string_functions.replace=function(string,re,sub,modifiers){var regexp=new RegExp(re,modifiers==undefined?"g":modifiers);if(!sub){sub=""}return string.replace(regexp,sub)};proto.string_functions.search=function(string,re){var regexp=new RegExp(re);return(string.search(regexp)>=0)?1:0};proto.string_functions.size=function(string){return 1};proto.string_functions.split=function(string,re){var regexp=new RegExp(re);var list=string.split(regexp);return list};proto.list_functions={};proto.list_functions["typeof"]=function(list){return"array"};proto.list_functions.list=function(list){return list};proto.list_functions.join=function(list,str){return list.join(str)};proto.list_functions.sort=function(list,key){if(typeof (key)!="undefined"&&key!=""){return list.sort(function(a,b){if(a[key]==b[key]){return 0}else{if(a[key]>b[key]){return 1}else{return -1}}})}return list.sort()};proto.list_functions.nsort=function(list){return list.sort(function(a,b){return(a-b)})};proto.list_functions.grep=function(list,re){var regexp=new RegExp(re);var result=[];for(var i=0;i<list.length;i++){if(list[i].match(regexp)){result.push(list[i])}}return result};proto.list_functions.unique=function(list){var result=[];var seen={};for(var i=0;i<list.length;i++){var elem=list[i];if(!seen[elem]){result.push(elem)}seen[elem]=true}return result};proto.list_functions.reverse=function(list){var result=[];for(var i=list.length-1;i>=0;i--){result.push(list[i])}return result};proto.list_functions.merge=function(list){var result=[];var push_all=function(elem){if(elem instanceof Array){for(var j=0;j<elem.length;j++){result.push(elem[j])}}else{result.push(elem)}};push_all(list);for(var i=1;i<arguments.length;i++){push_all(arguments[i])}return result};proto.list_functions.slice=function(list,start,end){if(end==-1){return list.slice(start)}return list.slice(start,end+1)};proto.list_functions.splice=function(list){var args=Array.prototype.slice.call(arguments);args.shift();return list.splice.apply(list,args)};proto.list_functions.push=function(list,value){list.push(value);return list};proto.list_functions.pop=function(list){return list.pop()};proto.list_functions.unshift=function(list,value){list.unshift(value);return list};proto.list_functions.shift=function(list){return list.shift()};proto.list_functions.first=function(list){return list[0]};proto.list_functions.size=function(list){return list.length};proto.list_functions.max=function(list){return list.length-1};proto.list_functions.last=function(list){return list.slice(-1)};proto.hash_functions={};proto.hash_functions["typeof"]=function(hash){return"object"};proto.hash_functions.each=function(hash){var list=new Array();for(var key in hash){list.push(key,hash[key])}return list};proto.hash_functions.exists=function(hash,key){return(typeof (hash[key])=="undefined")?0:1};proto.hash_functions["import"]=function(hash,hash2){for(var key in hash2){hash[key]=hash2[key]}return""};proto.hash_functions.keys=function(hash){var list=new Array();for(var key in hash){list.push(key)}return list};proto.hash_functions.list=function(hash,what){var list=new Array();var key;if(what=="keys"){for(key in hash){list.push(key)}}else{if(what=="values"){for(key in hash){list.push(hash[key])}}else{if(what=="each"){for(key in hash){list.push(key,hash[key])}}else{for(key in hash){list.push({"key":key,"value":hash[key]})}}}}return list};proto.hash_functions.nsort=function(hash){var list=new Array();for(var key in hash){list.push(key)}return list.sort(function(a,b){return(a-b)})};proto.hash_functions.item=function(hash,key){return hash[key]};proto.hash_functions.size=function(hash){var size=0;for(var key in hash){size++}return size};proto.hash_functions.sort=function(hash){var list=new Array();for(var key in hash){list.push(key)}return list.sort()};proto.hash_functions.values=function(hash){var list=new Array();for(var key in hash){list.push(hash[key])}return list};proto.hash_functions.pairs=function(hash){var list=new Array();var keys=new Array();for(var key in hash){keys.push(key)}keys.sort();for(var key in keys){key=keys[key];list.push({"key":key,"value":hash[key]})}return list};proto.hash_functions.remove=function(hash,key){return delete hash[key]};proto.hash_functions["delete"]=proto.hash_functions.remove;if(typeof Jemplate.Iterator=="undefined"){Jemplate.Iterator=function(object){if(object instanceof Array){this.object=object;this.size=object.length;this.max=this.size-1}else{if(object instanceof Object){this.object=object;var object_keys=new Array;for(var key in object){object_keys[object_keys.length]=key}this.object_keys=object_keys.sort();this.size=object_keys.length;this.max=this.size-1}else{if(typeof object=="undefined"||object==null||object==""){this.object=null;this.max=-1}}}}}proto=Jemplate.Iterator.prototype;proto.get_first=function(){this.index=0;this.first=1;this.last=0;this.count=1;return this.get_next(1)};proto.get_next=function(should_init){var object=this.object;var index;if(typeof (should_init)!="undefined"&&should_init){index=this.index}else{index=++this.index;this.first=0;this.count=this.index+1;if(this.index==this.size-1){this.last=1}}if(typeof object=="undefined"){throw ("No object to iterate")}if(this.object_keys){if(index<this.object_keys.length){this.prev=index>0?this.object_keys[index-1]:"";this.next=index<this.max?this.object_keys[index+1]:"";return[this.object_keys[index],false]}}else{if(index<=this.max){this.prev=index>0?object[index-1]:"";this.next=index<this.max?object[index+1]:"";return[object[index],false]}}return[null,true]};var stubExplanation="stub that doesn't do anything. Try including the jQuery, YUI, or XHR option when building the runtime";Jemplate.Ajax={get:function(url,callback){throw ("This is a Jemplate.Ajax.get "+stubExplanation)},processGet:function(url,callback){throw ("This is a Jemplate.Ajax.processGet "+stubExplanation)},post:function(url,callback){throw ("This is a Jemplate.Ajax.post "+stubExplanation)}};Jemplate.JSON={parse:function(decodeValue){throw ("This is a Jemplate.JSON.parse "+stubExplanation)},stringify:function(encodeValue){throw ("This is a Jemplate.JSON.stringify "+stubExplanation)}}}())
...
}

sub ajax_jquery {
    <<'...';
(function(){Jemplate.Ajax={get:function(A,B){jQuery.get(A,null,B)},processGet:function(A,B){jQuery.getJSON(A,null,B)},post:function(A,B,C){jQuery.post(A,B,C)}}}())
...
}

sub ajax_xhr {
    <<'...';
(function(){Jemplate.Ajax={get:function(A,C){var B=new XMLHttpRequest();B.open("GET",A,Boolean(C));B.setRequestHeader("Accept","text/json; text/x-json; application/json");return this.request(B,null,C)},processGet:function(A,B){this.get(A,function(C){B(Jemplate.JSON.parse(C))})},post:function(A,C,D){var B=new XMLHttpRequest();B.open("POST",A,Boolean(D));B.setRequestHeader("Accept","text/json; text/x-json; application/json");B.setRequestHeader("Content-Type","application/x-www-form-urlencoded");return this.request(B,C,D)},request:function(A,B,C){if(C){A.onreadystatechange=function(){if(A.readyState==4){if(A.status==200){C(A.responseText)}}}}A.send(B);if(!C){if(A.status!=200){throw ('Request for "'+url+'" failed with status: '+A.status)}return A.responseText}return null}}}())
...
}

sub ajax_yui {
    <<'...';
(function(){Jemplate.Ajax={get:function(A,B){if(typeof B=="function"){B={success:B}}YAHOO.connect.asyncRequest("GET",A,B)},processGet:function(A,B){this.get(A,function(C){B(YAHOO.lang.JSON.parse(C))})},post:function(A,B,C){if(typeof C=="function"){C={success:C}}YAHOO.connect.asyncRequest("POST",A,C,B)}}}())
...
}

sub json_json2 {
    <<'...';
(function(){Jemplate.JSON={parse:function(A){return JSON.parse(A)},stringify:function(A){return JSON.stringify(A)}}}())
...
}

sub json_json2_internal {
    <<'...';
;(function(){

var JSON;

if(!this.JSON){this.JSON={}}(function(){function f(n){return n<10?"0"+n:n}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(key){return this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z"};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){return this.valueOf()}}var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==="object"&&typeof value.toJSON==="function"){value=value.toJSON(key)}if(typeof rep==="function"){value=rep.call(holder,key,value)}switch(typeof value){case"string":return quote(value);case"number":return isFinite(value)?String(value):"null";case"boolean":case"null":return String(value);case"object":if(!value){return"null"}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==="[object Array]"){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||"null"}v=partial.length===0?"[]":gap?"[\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"]":"["+partial.join(",")+"]";gap=mind;return v}if(rep&&typeof rep==="object"){length=rep.length;for(i=0;i<length;i+=1){k=rep[i];if(typeof k==="string"){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}else{for(k in value){if(Object.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}v=partial.length===0?"{}":gap?"{\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"}":"{"+partial.join(",")+"}";gap=mind;return v}return""}if(typeof JSON.stringify!=="function"){JSON.stringify=function(value,replacer,space){var i;gap="";indent="";if(typeof space==="number"){for(i=0;i<space;i+=1){indent+=" "}}else{if(typeof space==="string"){indent=space}}rep=replacer;if(replacer&&typeof replacer!=="function"&&(typeof replacer!=="object"||typeof replacer.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":value})}}if(typeof JSON.parse!=="function"){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==="object"){for(k in value){if(Object.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}}())

Jemplate.JSON={parse:function(A){return JSON.parse(A)},stringify:function(A){return JSON.stringify(A)}}

}());
...
}

sub json_yui {
    <<'...';
(function(){Jemplate.JSON={parse:function(A){return YAHOO.lang.JSON.parse(A)},stringify:function(A){return YAHOO.lang.JSON.stringify(A)}}}())
...
}

sub json2 {
    <<'...';
if(!this.JSON){this.JSON={}}(function(){function f(n){return n<10?"0"+n:n}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(key){return this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z"};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){return this.valueOf()}}var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==="object"&&typeof value.toJSON==="function"){value=value.toJSON(key)}if(typeof rep==="function"){value=rep.call(holder,key,value)}switch(typeof value){case"string":return quote(value);case"number":return isFinite(value)?String(value):"null";case"boolean":case"null":return String(value);case"object":if(!value){return"null"}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==="[object Array]"){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||"null"}v=partial.length===0?"[]":gap?"[\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"]":"["+partial.join(",")+"]";gap=mind;return v}if(rep&&typeof rep==="object"){length=rep.length;for(i=0;i<length;i+=1){k=rep[i];if(typeof k==="string"){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}else{for(k in value){if(Object.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}v=partial.length===0?"{}":gap?"{\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"}":"{"+partial.join(",")+"}";gap=mind;return v}return""}if(typeof JSON.stringify!=="function"){JSON.stringify=function(value,replacer,space){var i;gap="";indent="";if(typeof space==="number"){for(i=0;i<space;i+=1){indent+=" "}}else{if(typeof space==="string"){indent=space}}rep=replacer;if(replacer&&typeof replacer!=="function"&&(typeof replacer!=="object"||typeof replacer.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":value})}}if(typeof JSON.parse!=="function"){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==="object"){for(k in value){if(Object.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}}())
...
}

sub xhr_gregory {
    <<'...';
if(window.ActiveXObject&&!window.XMLHttpRequest){window.XMLHttpRequest=function(){var C=new Array("Msxml2.XMLHTTP.5.0","Msxml2.XMLHTTP.4.0","Msxml2.XMLHTTP.3.0","Msxml2.XMLHTTP","Microsoft.XMLHTTP");for(var A=0;A<C.length;A++){try{return new ActiveXObject(C[A])}catch(B){}}return null}}if(window.opera&&!window.XMLHttpRequest){window.XMLHttpRequest=function(){this.readyState=0;this.status=0;this.statusText="";this._headers=[];this._aborted=false;this._async=true;this._defaultCharset="ISO-8859-1";this._getCharset=function(){var B=_defaultCharset;var A=this.getResponseHeader("Content-type").toUpperCase();val=A.indexOf("CHARSET=");if(val!=-1){B=A.substring(val)}val=B.indexOf(";");if(val!=-1){B=B.substring(0,val)}val=B.indexOf(",");if(val!=-1){B=B.substring(0,val)}return B};this.abort=function(){this._aborted=true};this.getAllResponseHeaders=function(){return this.getAllResponseHeader("*")};this.getAllResponseHeader=function(C){var A="";for(var B=0;B<this._headers.length;B++){if(C=="*"||this._headers[B].h==C){A+=this._headers[B].h+": "+this._headers[B].v+"\n"}}return A};this.getResponseHeader=function(C){var A=getAllResponseHeader(C);var B=A.indexOf("\n");if(B!=-1){A=A.substring(0,B)}return A};this.setRequestHeader=function(B,A){this._headers[this._headers.length]={h:B,v:A}};this.open=function(E,C,D,A,B){this.method=E;this.url=C;this._async=true;this._aborted=false;this._headers=[];if(arguments.length>=3){this._async=D}if(arguments.length>3){opera.postError("XMLHttpRequest.open() - user/password not supported")}this.readyState=1;if(this.onreadystatechange){this.onreadystatechange()}};this.send=function(A){if(!navigator.javaEnabled()){alert("XMLHttpRequest.send() - Java must be installed and enabled.");return }if(this._async){setTimeout(this._sendasync,0,this,A)}else{this._sendsync(A)}};this._sendasync=function(A,B){if(!A._aborted){A._sendsync(B)}};this._sendsync=function(Q){this.readyState=2;if(this.onreadystatechange){this.onreadystatechange()}var F=new java.net.URL(new java.net.URL(window.location.href),this.url);var I=F.openConnection();for(var O=0;O<this._headers.length;O++){I.setRequestProperty(this._headers[O].h,this._headers[O].v)}this._headers=[];if(this.method=="POST"){I.setDoOutput(true);var B=new java.io.OutputStreamWriter(I.getOutputStream(),this._getCharset());B.write(Q);B.flush();B.close()}var L=false;var J=false;var E=false;var C=false;var H=false;var P=false;for(var O=0;;O++){var N=I.getHeaderFieldKey(O);var K=I.getHeaderField(O);if(N==null&&K==null){break}if(N!=null){this._headers[this._headers.length]={h:N,v:K};switch(N.toLowerCase()){case"content-encoding":L=true;break;case"content-length":J=true;break;case"content-type":E=true;break;case"date":C=true;break;case"expires":H=true;break;case"last-modified":P=true;break}}}var R;R=I.getContentEncoding();if(R!=null&&!L){this._headers[this._headers.length]={h:"Content-encoding",v:R}}R=I.getContentLength();if(R!=-1&&!J){this._headers[this._headers.length]={h:"Content-length",v:R}}R=I.getContentType();if(R!=null&&!E){this._headers[this._headers.length]={h:"Content-type",v:R}}R=I.getDate();if(R!=0&&!C){this._headers[this._headers.length]={h:"Date",v:(new Date(R)).toUTCString()}}R=I.getExpiration();if(R!=0&&!H){this._headers[this._headers.length]={h:"Expires",v:(new Date(R)).toUTCString()}}R=I.getLastModified();if(R!=0&&!P){this._headers[this._headers.length]={h:"Last-modified",v:(new Date(R)).toUTCString()}}var D="";var G=I.getInputStream();if(G){var A=new java.io.BufferedReader(new java.io.InputStreamReader(G,this._getCharset()));var M;while((M=A.readLine())!=null){if(this.readyState==2){this.readyState=3;if(this.onreadystatechange){this.onreadystatechange()}}D+=M+"\n"}A.close();this.status=200;this.statusText="OK";this.responseText=D;this.readyState=4;if(this.onreadystatechange){this.onreadystatechange()}if(this.onload){this.onload()}}else{this.status=404;this.statusText="Not Found";this.responseText="";this.readyState=4;if(this.onreadystatechange){this.onreadystatechange()}if(this.onerror){this.onerror()}}}}}if(!window.ActiveXObject&&window.XMLHttpRequest){window.ActiveXObject=function(A){switch(A.toLowerCase()){case"microsoft.xmlhttp":case"msxml2.xmlhttp":case"msxml2.xmlhttp.3.0":case"msxml2.xmlhttp.4.0":case"msxml2.xmlhttp.5.0":return new XMLHttpRequest()}return null}}
...
}

sub xhr_ilinsky {
    <<'...';
(function(){var D=window.XMLHttpRequest;var H=!!window.controllers,E=window.document.all&&!window.opera;function C(){this._object=D?new D:new window.ActiveXObject("Microsoft.XMLHTTP")}if(H&&D.wrapped){C.wrapped=D.wrapped}C.UNSENT=0;C.OPENED=1;C.HEADERS_RECEIVED=2;C.LOADING=3;C.DONE=4;C.prototype.readyState=C.UNSENT;C.prototype.responseText="";C.prototype.responseXML=null;C.prototype.status=0;C.prototype.statusText="";C.prototype.onreadystatechange=null;C.onreadystatechange=null;C.onopen=null;C.onsend=null;C.onabort=null;C.prototype.open=function(L,O,K,P,J){this._async=K;var N=this,M=this.readyState;if(E){var I=function(){if(N._object.readyState!=C.DONE){A(N)}};if(K){window.attachEvent("onunload",I)}}this._object.onreadystatechange=function(){if(H&&!K){return }N.readyState=N._object.readyState;G(N);if(N._aborted){N.readyState=C.UNSENT;return }if(N.readyState==C.DONE){A(N);if(E&&K){window.detachEvent("onunload",I)}}if(M!=N.readyState){F(N)}M=N.readyState};if(C.onopen){C.onopen.apply(this,arguments)}this._object.open(L,O,K,P,J);if(!K&&H){this.readyState=C.OPENED;F(this)}};C.prototype.send=function(I){if(C.onsend){C.onsend.apply(this,arguments)}if(I&&I.nodeType){I=window.XMLSerializer?new window.XMLSerializer().serializeToString(I):I.xml;if(!this._headers["Content-Type"]){this._object.setRequestHeader("Content-Type","application/xml")}}this._object.send(I);if(H&&!this._async){this.readyState=C.OPENED;G(this);while(this.readyState<C.DONE){this.readyState++;F(this);if(this._aborted){return }}}};C.prototype.abort=function(){if(C.onabort){C.onabort.apply(this,arguments)}if(this.readyState>C.UNSENT){this._aborted=true}this._object.abort();A(this)};C.prototype.getAllResponseHeaders=function(){return this._object.getAllResponseHeaders()};C.prototype.getResponseHeader=function(I){return this._object.getResponseHeader(I)};C.prototype.setRequestHeader=function(I,J){if(!this._headers){this._headers={}}this._headers[I]=J;return this._object.setRequestHeader(I,J)};C.prototype.toString=function(){return"[object XMLHttpRequest]"};C.toString=function(){return"[XMLHttpRequest]"};function F(I){if(I.onreadystatechange){I.onreadystatechange.apply(I)}if(C.onreadystatechange){C.onreadystatechange.apply(I)}}function B(J){var I=J.responseXML;if(E&&I&&!I.documentElement&&J.getResponseHeader("Content-Type").match(/[^\/]+\/[^\+]+\+xml/)){I=new ActiveXObject("Microsoft.XMLDOM");I.loadXML(J.responseText)}if(I){if((E&&I.parseError!=0)||(I.documentElement&&I.documentElement.tagName=="parsererror")){return null}}return I}function G(I){try{I.responseText=I._object.responseText}catch(J){}try{I.responseXML=B(I._object)}catch(J){}try{I.status=I._object.status}catch(J){}try{I.statusText=I._object.statusText}catch(J){}}function A(I){I._object.onreadystatechange=new window.Function;delete I._headers}if(!window.Function.prototype.apply){window.Function.prototype.apply=function(I,J){if(!J){J=[]}I.__func=this;I.__func(J[0],J[1],J[2],J[3],J[4]);delete I.__func}}window.XMLHttpRequest=C})()
...
}

sub xxx {
    <<'...';
function XXX(A){if(!confirm(A)){throw ("terminated...")}return A}function JJJ(A){return XXX(JSON.stringify(A))}
...
}

1;

__END__

=encoding UTF-8

=head1 NAME

Jemplate::Runtime - Perl Module containing the Jemplate JavaScript Runtime

=head1 SYNOPSIS

    use Jemplate::Runtime;
    print Jemplate::Runtime->main;

=head1 DESCRIPTION

This module is auto-generated and used internally by Jemplate. It
contains subroutines that simply return various parts of the Jemplate
JavaScript Runtime code.

=head1 METHODS

head2 kernel

head2 ajax_jquery

head2 ajax_xhr

head2 ajax_yui

head2 json_json2

head2 json_yui

head2 json2

head2 xhr_gregory

head2 xhr_ilinsky

head2 xxx

=head1 COPYRIGHT

Copyright (c) 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
