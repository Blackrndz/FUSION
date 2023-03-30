/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ITEM_CLASS_NAME
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS 
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
,ImportFormatEO.MAPPING_NAME RES_NAME
,ImportFormatEO.MAPPING_DESCRIPTION RES_DESCRIPTION
,(SELECT MAPPING_NAME
	FROM EGI_IO_MAP_VL
	WHERE MAPPING_ID = ImportFormatEO.PARENT_MAPPING_ID
	) RES_SOURCE_FORMAT
,DECODE(ImportFormatEO.DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT
,DECODE(ImportFormatEO.ACTIVE_FLAG,'Y','Yes','No') RES_ACTIVE
,DECODE(ImportFormatEO.INCLUDE_REQUIRED_ATTRIBUTES,'N','No','Yes') RES_INCLUDE_REQUIRED_ATTRIBUTE
,ImportFormatEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ImportFormatEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ImportFormatEO.CREATED_BY  RSC_CREATED_BY
,ImportFormatEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,EGI_IO_MAP_VL ImportFormatEO
WHERE ItemClassPEO.ITEM_CLASS_ID = ImportFormatEO.ITEM_CLASS_ID
AND ImportFormatEO.TYPE = 'F'
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS