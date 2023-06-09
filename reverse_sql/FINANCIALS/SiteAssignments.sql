/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-09-14  $:
 * $HeadURL: $:
 * $Id: Manage Suppliers - Supplier Site Assignments.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- STRICTLY_BATCH_SEQ = RES_SUPPLIER_NAME,RES_PROCUREMENT_BU,RES_SUPPLIER_SITE,RES_CLIENT_BU
 
SELECT 'CREATE' RES_IMPORT_ACTION
,(SELECT PersonParty.PARTY_NAME 
	FROM HZ_PARTIES PersonParty 
	WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
	) RES_SUPPLIER_NAME
,SupplierSiteDEO.VENDOR_SITE_CODE RES_SUPPLIER_SITE
,(SELECT BusinessUnitPEO.BU_NAME 
	FROM FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	WHERE BusinessUnitPEO.BU_ID = SupplierSiteDEO.PRC_BU_ID  
	) RES_PROCUREMENT_BU
,(SELECT BusinessUnitPEO.BU_NAME 
	FROM FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	WHERE BusinessUnitPEO.BU_ID = Poz_Assign.BU_ID
	) RES_CLIENT_BU
,(SELECT BusinessUnitPEO.BU_NAME 
	FROM FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	WHERE BusinessUnitPEO.BU_ID = Poz_Assign.BILL_TO_BU_ID 
	) RES_BILL_TO_BU
,(SELECT Distinct LOCATION_CODE  
	FROM HR_LOCATIONS_ALL_F_VL LocationDPEO
	WHERE LocationDPEO.LOCATION_ID = Poz_Assign.SHIP_TO_LOCATION_ID 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_SHIP_TO_LOCATION
,(SELECT Distinct LOCATION_CODE  
	FROM HR_LOCATIONS_ALL_F_VL LocationDPEO
	WHERE LocationDPEO.LOCATION_ID = Poz_Assign.BILL_TO_LOCATION_ID 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_BILL_TO_LOCATION
,Poz_Assign.ALLOW_AWT_FLAG RES_USE_WITHHOLDING_TAX
,(SELECT Distinct CONDITION_GROUP_NAME
	FROM ZX_CONDITION_GROUPS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CONDITION_GROUP_ID = Poz_Assign.AWT_GROUP_ID 
	) RES_WITHHOLDING_TAX_GROUP
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = Poz_Assign.ACCTS_PAY_CODE_COMBINATION_ID)
	,COMBINATION_ID => Poz_Assign.ACCTS_PAY_CODE_COMBINATION_ID
	) RES_LIABILITY_DISTRIBUTION
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = Poz_Assign.PREPAY_CODE_COMBINATION_ID)
	,COMBINATION_ID => Poz_Assign.PREPAY_CODE_COMBINATION_ID
	) RES_PREPAYMENT_DISTRIBUTION
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = Poz_Assign.FUTURE_DATED_PAYMENT_CCID)
	,COMBINATION_ID => Poz_Assign.FUTURE_DATED_PAYMENT_CCID
	) RES_BILLS_PAYABLE_DISTRIBUTION
,(SELECT Distinct DISTRIBUTION_SET_NAME
	FROM AP_DISTRIBUTION_SETS_ALL APDISTRIBUTIONSETSALL
	WHERE APDISTRIBUTIONSETSALL.DISTRIBUTION_SET_ID = Poz_Assign.DISTRIBUTION_SET_ID  
	) RES_DISTRIBUTION_SET
,TO_CHAR(Poz_Assign.INACTIVE_DATE,'YYYY/MM/DD') RES_INACTIVE_DATE
,NULL RES_BATCH_ID
,'END' RES_END
,Poz_Assign.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Poz_Assign.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Poz_Assign.CREATED_BY RSC_CREATED_BY
,Poz_Assign.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,SupplierSiteDEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POZ_SUPPLIER_SITES_ALL_M SupplierSiteDEO
,HZ_PARTY_SITES PartySitePEO
,POZ_SITE_ASSIGNMENTS_ALL_M Poz_Assign
WHERE SupplierSiteDEO.PARTY_SITE_ID = PartySitePEO.PARTY_SITE_ID(+)
AND SupplierSiteDEO.VENDOR_SITE_ID = Poz_Assign.VENDOR_SITE_ID
ORDER BY SupplierSiteDEO.VENDOR_SITE_CODE