/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_MEASURE_CATALOGS_VL

SELECT MeasureCatalogsE0.NAME RES_MEASURE_CATALOG_NAME
,MeasureCatalogsE0.DESCRIPTION RES_DESCRIPTION
,'' RES_STATUS
--,DECODE(MeasureCatalogsE0.IS_SOP_DEF_CATALOG,1,'Yes','No') RES_SALES_AND_OPERATIONS_PLANN
,MeasureCatalogsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,MeasureCatalogsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MeasureCatalogsE0.CREATED_BY  RSC_CREATED_BY
,MeasureCatalogsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_MEASURE_CATALOGS_VL MeasureCatalogsE0
ORDER BY 1