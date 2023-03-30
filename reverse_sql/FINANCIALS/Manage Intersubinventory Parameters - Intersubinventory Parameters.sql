/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organizations%20-%20General.sql $:
 * $Id: Manage Inventory Organizations - General.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_INTERSUB_PARAMETERS 

SElECT OrganizationParameterEO.ORGANIZATION_CODE RES_ORGANIZATION
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_INV_TO_DESTINATION_TYPE'
	AND LOOKUP_CODE = InvIntersubParametersE0.DESTINATION_TYPE
	) RES_DESTINATION_TYPE
,InvIntersubParametersE0.TO_SUBINVENTORY RES_DESTINATION_SUBINVENTORY
,NVL(InvIntersubParametersE0.FROM_SUBINVENTORY,'All') RES_SOURCE_SUBINVENTORY
,DECODE(InvIntersubParametersE0.MANUAL_RECEIPT_EXPENSE,'Y','Yes','No') RES_RECEIPT_REQUIRED_AT_EXPENS
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_IOP_TRANSIT_TYPE'
	AND LOOKUP_CODE = InvIntersubParametersE0.TRANSFER_TYPE
	) RES_INVENTORY_DESTINATION_TRAN
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_IOP_ROUTING_TYPE'
	AND LOOKUP_CODE = InvIntersubParametersE0.RECEIPT_ROUTING
	) RES_RECEIPT_ROUTING
,TO_CHAR(InvIntersubParametersE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(InvIntersubParametersE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,InvIntersubParametersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvIntersubParametersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvIntersubParametersE0.CREATED_BY RSC_CREATED_BY
,InvIntersubParametersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,InvIntersubParametersE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_INTERSUB_PARAMETERS InvIntersubParametersE0
,INV_ORG_PARAMETERS OrganizationParameterEO
WHERE InvIntersubParametersE0.ORGANIZATION_ID = OrganizationParameterEO.ORGANIZATION_ID
ORDER BY OrganizationParameterEO.ORGANIZATION_CODE
,InvIntersubParametersE0.DESTINATION_TYPE
,InvIntersubParametersE0.TO_SUBINVENTORY
,InvIntersubParametersE0.FROM_SUBINVENTORY