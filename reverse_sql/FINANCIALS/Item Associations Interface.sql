/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGP_SYSTEM_ITEMS_B
-- STRICTLY_BATCH_SEQ = RES_ITEM_NUMBER,RES_ORGANIZATION_CODE

SELECT 'CREATE' RES_TRANSACTION_TYPE
,'' RES_BATCH_ID
,'' RES_BATCH_NUMBER
,ItemsE0.ITEM_NUMBER RES_ITEM_NUMBER
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_ORGANIZATION_CODE
,'' RES_SOURCE_SYSTEM_CODE
,'' RES_SOURCE_SYSTEM_REFERENCE
,itemAssociationsE0.PRIMARY_FLAG RES_PRIMARY_FLAG
,itemAssociationsE0.STATUS_CODE RES_STATUS_CODE
,suppliersE0.PARTY_NAME RES_SUPPLIER_NAME
,suppliersE0.PARTY_NUMBER RES_SUPPLIER_NUMBER
,(SELECT PARTY_SITE_NAME
	FROM HZ_PARTY_SITES
	WHERE PARTY_ID = itemAssociationsE0.SUPPLIER_ID
	AND PARTY_SITE_ID = itemAssociationsE0.SUPPLIER_SITE_ID
	) RES_SUPPLIER_ADDRESS_NAME
,TO_CHAR(itemAssociationsE0.VERSION_START_DATE,'YYYY/MM/DD') RES_VERSION_START_DATE
,(SELECT VERSION_CODE
	FROM EGO_VERSIONS_B
	WHERE VERSION_ID = itemAssociationsE0.VERSION_ID
	) RES_VERSION_REVISION_CODE
,(SELECT STYLE_ITEM_FLAG
	FROM EGP_SYSTEM_ITEMS_B
	WHERE INVENTORY_ITEM_ID = itemAssociationsE0.STYLE_ITEM_ID
	AND ORGANIZATION_ID = itemAssociationsE0.ORGANIZATION_ID
	) RES_STYLE_ITEM_FLAG
,itemAssociationsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,itemAssociationsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,itemAssociationsE0.CREATED_BY  RSC_CREATED_BY
,itemAssociationsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,ItemsE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_SYSTEM_ITEMS_B ItemsE0
,EGO_ITEM_ASSOCIATIONS itemAssociationsE0
,HZ_PARTIES suppliersE0
WHERE ItemsE0.INVENTORY_ITEM_ID = itemAssociationsE0.INVENTORY_ITEM_ID
AND ItemsE0.ORGANIZATION_ID = itemAssociationsE0.ORGANIZATION_ID
AND itemAssociationsE0.SUPPLIER_ID = suppliersE0.PARTY_ID
AND ItemsE0.TEMPLATE_ITEM_FLAG = 'N'
AND ItemsE0.ACD_TYPE = 'PROD'