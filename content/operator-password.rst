operator password
#################
:date: 2011-11-01 00:19
:tags: de, java, password, pastebin, wtf

Es sieht nach einer Datenbank Debuggausgabe aus. Zumindest wird ein
kompletter Benutzer ausgegeben.

::

    DEBUG [scheduler-3] (PresenceManager.java:101) - checkExpiredSessions CALLED resetSessionOnStartup 0
    DEBUG [scheduler-3] (PresenceManager.java:133) - checkExpiredSessions CALLED refreshDate Thu Mar 31 13:11:02 EEST 2011
    Hibernate: select sessionlog0_.id as id18_, sessionlog0_.endTime as endTime18_, sessionlog0_.readOnly as readOnly18_, sessionlog0_.refreshTime as refreshT4_18_, sessionlog0_.sessionID as sessionID18_, sessionlog0_.startTime as startTime18_, sessionlog0_.status as status18_, sessionlog0_.userID as userID18_ from SESSION_LOGS sessionlog0_ where sessionlog0_.refreshTime<=? and sessionlog0_.status=?
     INFO [http-8080-7] (SignonService.java:168) - logout CALLED on user = User [accountState=ACTIVE, address=null, birthCityID=null, birthCityName=null, birthDate=null, cityId=null, customer=Customer [id=4, name=AvvocatiPerugia, registryMain=null, registryMngEn=true, bossManagementEnabled=true, studioMngEn=true, companiesOfProfessionistMngEn=true, institutionsMngEn=true, reportMngEn=true, addressBookEn=true, defenseMngEn=true, freeDefenseMngEn=true, taxCollectionMngEn=true, protocolMngEn=true, disciplinaryMngEn=true, billMngEn=true, cashMngEn=true, internetMngEn=true, helpMngEn=true, idDataSource=avvPerugiaDataSource, customerType=CustomerType [id=2, name=Avvocati, description=Lawyers], order=it.dcs.iscrivo.central.model.Order@85], email=null, fax=null, firstName=operator, fiscalCode=null, groups=[], id=125, lastAccessTime=2011-03-31 15:10:19.613, lastName=operator, mobile=null, notes=null, password=e10adc3949ba59abbe56e057f20f883e, phone1=null, phone2=null, phone3=null, postalCode=null, registrationDate=null, sex=null, username=operator]
    Hibernate: select user0_.id as id86_0_, user0_.accountState as accountS2_86_0_, user0_.address as address86_0_, user0_.addressBookMng as addressB4_86_0_, user0_.againstJudgesProcessesMng as againstJ5_86_0_, user0_.attemptedConciliationsMng as attempte6_86_0_, user0_.billMng as billMng86_0_, user0_.birthCityID as birthCit8_86_0_, user0_.birthCityName as birthCit9_86_0_, user0_.birthDate as birthDate86_0_, user0_.cashMng as cashMng86_0_, user0_.cityID as cityID86_0_, user0_.customerID as customerID86_0_, user0_.defenseMng as defenseMng86_0_, user0_.disciplinaryProcessesMng as discipl14_86_0_, user0_.email as email86_0_, user0_.fax as fax86_0_, user0_.firstName as firstName86_0_, user0_.fiscalCode as fiscalCode86_0_, user0_.freeDefenseAdminMng as freeDef19_86_0_, user0_.freeDefenseMng as freeDef20_86_0_, user0_.generalAffairsMng as general21_86_0_, user0_.informationProtocolMng as informa22_86_0_, user0_.lastAccessTime as lastAcc23_86_0_, user0_.lastName as lastName86_0_, user0_.mailMergeTemplatesMng as mailMer25_86_0_, user0_.mobile as mobile86_0_, user0_.notes as notes86_0_, user0_.password as password86_0_, user0_.passwordExpirationTime as passwor29_86_0_, user0_.phone1 as phone30_86_0_, user0_.phone2 as phone31_86_0_, user0_.phone3 as phone32_86_0_, user0_.postalCode as postalCode86_0_, user0_.preventiveRequestMng as prevent34_86_0_, user0_.processMng as processMng86_0_, user0_.receiptMng as receiptMng86_0_, user0_.registrationDate as registr37_86_0_, user0_.registryMng as registr38_86_0_, user0_.reportMng as reportMng86_0_, user0_.sex as sex86_0_, user0_.studioMng as studioMng86_0_, user0_.taxOfficeMng as taxOffi42_86_0_, user0_.username as username86_0_ from USERS user0_ where user0_.id=?
    Hibernate: select groups0_.userId as userId1_, groups0_.groupId as groupId1_, group1_.id as id75_0_, group1_.name as name75_0_ from USERS_GROUPS groups0_ left outer join GROUPS group1_ on groups0_.groupId=group1_.id where groups0_.userId=?
    Hibernate: select sessionlog0_.id as id18_, sessionlog0_.endTime as endTime18_, sessionlog0_.readOnly as readOnly18_, sessionlog0_.refreshTime as refreshT4_18_, sessionlog0_.sessionID as sessionID18_, sessionlog0_.startTime as startTime18_, sessionlog0_.status as status18_, sessionlog0_.userID as userID18_ from SESSION_LOGS sessionlog0_ where sessionlog0_.sessionID=? limit ?
    Hibernate: update USERS set accountState=?, address=?, addressBookMng=?, againstJudgesProcessesMng=?, attemptedConciliationsMng=?, billMng=?, birthCityID=?, birthCityName=?, birthDate=?, cashMng=?, cityID=?, customerID=?, defenseMng=?, disciplinaryProcessesMng=?, email=?, fax=?, firstName=?, fiscalCode=?, freeDefenseAdminMng=?, freeDefenseMng=?, generalAffairsMng=?, informationProtocolMng=?, lastAccessTime=?, lastName=?, mailMergeTemplatesMng=?, mobile=?, notes=?, password=?, passwordExpirationTime=?, phone1=?, phone2=?, phone3=?, postalCode=?, preventiveRequestMng=?, processMng=?, receiptMng=?, registrationDate=?, registryMng=?, reportMng=?, sex=?, studioMng=?, taxOfficeMng=?, username=? where id=?
    Hibernate: update SESSION_LOGS set endTime=?, readOnly=?, refreshTime=?, sessionID=?, startTime=?, status=?, userID=? where id=?
    org.icefaces.application.SessionExpiredException: Session has expired
        at org.icefaces.impl.application.SessionExpiredListener.sessionDestroyed(SessionExpiredListener.java:61)
        at org.apache.catalina.session.StandardSession.expire(StandardSession.java:702)
        at org.apache.catalina.session.StandardSession.expire(StandardSession.java:660)
        at org.apache.catalina.session.StandardSession.invalidate(StandardSession.java:1113)
        at org.apache.catalina.session.StandardSessionFacade.invalidate(StandardSessionFacade.java:150)
        at it.dcs.iscrivo.central.blogic.services.SignonService.logout(SignonService.java:185)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
        at java.lang.reflect.Method.invoke(Unknown Source)
        at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:307)
        at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:183)
        at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:150)
        at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:106)
        at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:172)
        at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:106)
        at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:172)
        at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:106)
        at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:172)
        at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:202)
        at $Proxy62.logout(Unknown Source)
        at it.dcs.iscrivo.central.web.Login.logout(Login.java:186)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
        at java.lang.reflect.Method.invoke(Unknown Source)
        at org.apache.el.parser.AstValue.invoke(AstValue.java:172)
        at org.apache.el.MethodExpressionImpl.invoke(MethodExpressionImpl.java:276)
        at com.sun.faces.facelets.el.TagMethodExpression.invoke(TagMethodExpression.java:98)
        at javax.faces.event.MethodExpressionActionListener.processAction(MethodExpressionActionListener.java:148)
        at javax.faces.event.ActionEvent.processListener(ActionEvent.java:88)
        at javax.faces.component.UIComponentBase.broadcast(UIComponentBase.java:772)
        at javax.faces.component.UICommand.broadcast(UICommand.java:300)
        at com.icesoft.faces.component.menubar.MenuItemBase.broadcast(MenuItemBase.java:86)
        at javax.faces.component.UIViewRoot.broadcastEvents(UIViewRoot.java:775)
        at javax.faces.component.UIViewRoot.processApplication(UIViewRoot.java:1267)
        at com.sun.faces.lifecycle.InvokeApplicationPhase.execute(InvokeApplicationPhase.java:82)
        at com.sun.faces.lifecycle.Phase.doPhase(Phase.java:101)
        at com.sun.faces.lifecycle.LifecycleImpl.execute(LifecycleImpl.java:118)
        at javax.faces.webapp.FacesServlet.service(FacesServlet.java:312)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:290)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:343)
        at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:109)
        at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:83)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:97)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:100)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:78)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:54)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:35)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:187)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:105)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:79)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.session.ConcurrentSessionFilter.doFilter(ConcurrentSessionFilter.java:109)
        at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:355)
        at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:149)
        at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:237)
        at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:167)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:235)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:206)
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:233)
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:191)
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:128)
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:102)
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:109)
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:293)
        at org.apache.coyote.http11.Http11Processor.process(Http11Processor.java:849)
        at org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler.process(Http11Protocol.java:583)
        at org.apache.tomcat.util.net.JIoEndpoint$Worker.run(JIoEndpoint.java:454)
        at java.lang.Thread.run(Unknown Source)%

(Quelle: `http://pastebin.com/nwYEPhWm`_) Interressant ist die INFO
Zeile, denn da steht folgendes drin:

::

     INFO [http-8080-7] (SignonService.java:168) - 
    logout CALLED on user = User [
      accountState=ACTIVE, 
      address=null, 
      birthCityID=null, 
      birthCityName=null, 
      birthDate=null, 
      cityId=null, 
      customer=Customer [ 
        id=4, 
        name=AvvocatiPerugia, 
        registryMain=null, 
        registryMngEn=true, 
        bossManagementEnabled=true, 
        studioMngEn=true, 
        companiesOfProfessionistMngEn=true, 
        institutionsMngEn=true, 
        reportMngEn=true, 
        addressBookEn=true, 
        defenseMngEn=true, 
        freeDefenseMngEn=true, 
        taxCollectionMngEn=true, 
        protocolMngEn=true, 
        disciplinaryMngEn=true, 
        billMngEn=true, 
        cashMngEn=true, 
        internetMngEn=true, 
        helpMngEn=true, 
        idDataSource=avvPerugiaDataSource, 
        customerType=CustomerType [
          id=2, 
          name=Avvocati, 
          description=Lawyers
        ], 
        order=it.dcs.iscrivo.central.model.Order@85
      ], 
      email=null, 
      fax=null, 
      firstName=operator, 
      fiscalCode=null, 
      groups=[], 
      id=125, 
      lastAccessTime=2011-03-31 15:10:19.613, 
      lastName=operator, 
      mobile=null, 
      notes=null, 
      password=e10adc3949ba59abbe56e057f20f883e, 
      phone1=null, 
      phone2=null, 
      phone3=null, 
      postalCode=null, 
      registrationDate=null, 
      sex=null, 
      username=operator
    ]

Damit waere wohl alles geklaert :) Den hash koennt ihr uebrigens selber
entschluesseln ;) ist auch nichts besonderes. so long

.. _`http://pastebin.com/nwYEPhWm`: http://pastebin.com/nwYEPhWm
