/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PoDocStyleHeaders.STYLE_NAME RES_STYLE
,PurchasingLineTypePEO.LINE_TYPE RES_LINE_TYPES
,PoDocStyleValues.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PoDocStyleValues.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PoDocStyleValues.CREATED_BY  RSC_CREATED_BY
,PoDocStyleValues.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM PO_DOC_STYLE_HEADERS PoDocStyleHeaders
,PO_DOC_STYLE_VALUES PoDocStyleValues
,PO_LINE_TYPES_VL PurchasingLineTypePEO
WHERE PoDocStyleValues.STYLE_ATTRIBUTE_NAME = 'LINE_TYPES'
AND PoDocStyleHeaders.STYLE_ID = PoDocStyleValues.STYLE_ID
AND PoDocStyleValues.STYLE_ALLOWED_VALUE = PurchasingLineTypePEO.LINE_TYPE_ID
ORDER BY PoDocStyleHeaders.STYLE_NAME
,PurchasingLineTypePEO.LINE_TYPE