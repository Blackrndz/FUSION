/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Meals.sql $:
* $Id: Manage Expense Fields by Category - Meals.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_MATRIX_CLASSES_VL

SELECT matrixClassesE0.DYNAMIC_MATRIX_CLASS_NAME RES_NAME
,matrixConditionsE0.DYNAMIC_MATRIX_DIMENSION_NAME RES_CONDITION_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_MTRXR_DIMN_DOMAIN_TYPES'
	AND LOOKUP_CODE = matrixConditionsE0.DOMAIN_TYPE_CODE
	) RES_DOMAIN_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_MTRXR_DIMN_DATA_TYPES'
	AND LOOKUP_CODE = matrixConditionsE0.DATA_TYPE_CODE
	) RES_DATA_TYPE
,(CASE
	WHEN matrixConditionsE0.DATA_TYPE_CODE = 'STRING' THEN
		matrixConditionsE0.DEFAULT_VALUE_TEXT
	WHEN matrixConditionsE0.DATA_TYPE_CODE = 'NUMBER' THEN
		TO_CHAR(matrixConditionsE0.DEFAULT_VALUE_NUMBER)
	WHEN matrixConditionsE0.DATA_TYPE_CODE = 'DATE' THEN
		TO_CHAR(matrixConditionsE0.DEFAULT_VALUE_DATE,'DD-Mon-YYYY')
	WHEN matrixConditionsE0.DATA_TYPE_CODE = 'TIMESTAMP' THEN
		TO_CHAR(matrixConditionsE0.DEFAULT_VALUE_TIMESTAMP,'DD-Mon-YYYY HH12:MI:SS')
	END) RES_DEFAULT_VALUE
,DECODE(matrixConditionsE0.DEFAULT_FIXED_VALUE_FLAG,'Y','Yes','No') RES_DEFAULT_IS_FIXED_VALUE
,DECODE(matrixConditionsE0.DISP_DEFVAL_ADMIN_UI_FLAG,'Y','Yes','No') RES_FIXED_COLUMN_IS_DISPLAYED
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'LOOK_UP' THEN
		matrixConditionsE0.DOMAIN_LOOK_UP_CODE
	END) RES_LOOKUP
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		DECODE(matrixConditionsE0.APP_MODULE_NAME
			,'oracle.apps.scm.doo.common.process.model.applicationModule.DooExtensibleMapperAM','DooExtensibleMapperAM (oracle.apps.scm.doo.common.process.model.applicationModule.DooExtensibleMapperAM)'
			,'oracle.apps.contracts.coreAuthoring.entitlements.service.applicationModule.ContractsSrvcEntitlementsServiceAM','Entitlements Service (oracle.apps.contracts.coreAuthoring.entitlements.service.applicationModule.ContractsSrvcEntitlementsServiceAM)'
			,'oracle.apps.scm.pricing.common.publicModel.applicationModule.MatrixDomainAM','MatrixDomainAM (oracle.apps.scm.pricing.common.publicModel.applicationModule.MatrixDomainAM)'
			,'oracle.apps.scm.fom.manageOrders.uiModel.applicationModule.ManageOrdersAM','ManageOrdersAM (oracle.apps.scm.fom.manageOrders.uiModel.applicationModule.ManageOrdersAM)'
			,'oracle.apps.contracts.coreAuthoring.pricing.util.model.applicationModule.ContractPricingUtilAM','ContractPricingUtilAM (oracle.apps.contracts.coreAuthoring.pricing.util.model.applicationModule.ContractPricingUtilAM)'
			,'oracle.apps.scm.doo.common.pricing.integration.applicationModule.PricingProcessAM','PricingProcessAM (oracle.apps.scm.doo.common.pricing.integration.applicationModule.PricingProcessAM)'
			,'oracle.apps.contracts.coreAuthoring.lines.model.applicationModule.ContractLineAM','ContractLineAM (oracle.apps.contracts.coreAuthoring.lines.model.applicationModule.ContractLineAM)'
			,'oracle.apps.scm.fos.orchestrationProcesses.transferPrice.publicModel.pricingIntegration.applicationModule.PricingProcessAM','PricingProcessAM (oracle.apps.scm.fos.orchestrationProcesses.transferPrice.publicModel.pricingIntegration.applicationModule.PricingProcessAM)'
			,'oracle.apps.contracts.coreAuthoring.transaction.contractService.applicationModule.ContractAM','ContractAM (oracle.apps.contracts.coreAuthoring.transaction.contractService.applicationModule.ContractAM)'
			,'oracle.apps.contracts.coreAuthoring.contractService.applicationModule.ContractAM','Contract (oracle.apps.contracts.coreAuthoring.contractService.applicationModule.ContractAM)'
			,'oracle.apps.contracts.coreAuthoring.contractDefaults.model.applicationModule.ContractDefaultsAM','ContractDefaultsAM (oracle.apps.contracts.coreAuthoring.contractDefaults.model.applicationModule.ContractDefaultsAM)'
			,'oracle.apps.crm.service.svcMgmt.srMgmt.srMilestoneService.applicationModule.SrMilestoneAM','SrMilestoneAM (oracle.apps.crm.service.svcMgmt.srMgmt.srMilestoneService.applicationModule.SrMilestoneAM)'
			,'oracle.apps.scm.pricing.priceExecution.pricingProcesses.publicModel.applicationModule.PricingProcessAM','PricingProcessAM (oracle.apps.scm.pricing.priceExecution.pricingProcesses.publicModel.applicationModule.PricingProcessAM)'
			,'oracle.apps.contracts.coreAuthoring.qocIntegration.publicModel.applicationModule.QocIntegrationAM','QocIntegrationAM (oracle.apps.contracts.coreAuthoring.qocIntegration.publicModel.applicationModule.QocIntegrationAM)'
			,'oracle.apps.contracts.coreAuthoring.coverage.publicModel.applicationModule.ContractCoverageAM','ContractCoverageAM (oracle.apps.contracts.coreAuthoring.coverage.publicModel.applicationModule.ContractCoverageAM)')
	END) RES_APPLICATION_MODULE
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		matrixConditionsE0.APP_CONFIG
	END) RES_CONFIGURATION
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		matrixConditionsE0.DOMAIN_VO_NAME
	END) RES_VIEW_OBJECT
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		matrixConditionsE0.DOMAIN_VO_KEY_ATTR
	END) RES_KEY_ATTRIBUTE
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		matrixConditionsE0.DOMAIN_VO_DISPLAY_ATTR
	END) RES_DISPLAY_ATTRIBUTE
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'VIEW_OBJECT_QUERY' THEN
		matrixConditionsE0.DOMAIN_VO_VC_NAME
	END) RES_VIEW_CRITERIA
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'ITEM_EXT_ATTR' THEN
		''
	END) RES_ATTRIBUTE
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'ITEM_EXT_ATTR' THEN
		''
	END) RES_VALUE_SET
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'ITEM_EXT_ATTR' THEN
		''
	END) RES_ATTRIBUTE_GROUP_IDENTIFIER
,(CASE
	WHEN matrixConditionsE0.DOMAIN_TYPE_CODE = 'ITEM_EXT_ATTR' THEN
		''
	END) RES_ATTRIBUTE_IDENTIFIER
,matrixConditionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,matrixConditionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,matrixConditionsE0.CREATED_BY  RSC_CREATED_BY
,matrixConditionsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_MATRIX_CLASSES_VL matrixClassesE0
,QP_MATRIX_DIMENSIONS_VL matrixConditionsE0
WHERE matrixClassesE0.DYNAMIC_MATRIX_CLASS_ID = matrixConditionsE0.DYNAMIC_MATRIX_CLASS_ID
AND matrixClassesE0.OWNER_APPLICATION = 'pricing'
AND matrixConditionsE0.DIMENSION_TYPE = 'Condition'
ORDER BY matrixClassesE0.DYNAMIC_MATRIX_CLASS_NAME
,matrixConditionsE0.DISPLAY_SEQUENCE_NUM