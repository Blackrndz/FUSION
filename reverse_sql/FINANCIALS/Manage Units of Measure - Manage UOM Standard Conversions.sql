/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Units%20of%20Measure%20-%20Manage%20UOM%20Standard%20Conversions.sql $:
 * $Id: Manage Units of Measure - Manage UOM Standard Conversions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT uom1.unit_of_measure RES_UOM_NAME
,uom1.description RES_DESCRIPTION
,UNITOFMEASURECONVERSIONEO.CONVERSION_RATE RES_CONVERSION
,uom2.unit_of_measure RES_BASE_UOM_NAME
,CLASS.UOM_CLASS_TL RES_CLASS_NAME
,to_char(UNITOFMEASURECONVERSIONEO.DISABLE_DATE,'DD-Mon-YYYY') RES_END_DATE
,UNITOFMEASURECONVERSIONEO.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,UNITOFMEASURECONVERSIONEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,UNITOFMEASURECONVERSIONEO.CREATED_BY  RSC_CREATED_BY
,UNITOFMEASURECONVERSIONEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
    
FROM INV_UNITS_OF_MEASURE uom1
,INV_UNITS_OF_MEASURE uom2
,INV_UOM_CLASSES CLASS
,INV_UOM_CONVERSIONS UNITOFMEASURECONVERSIONEO
WHERE uom1.uom_class      = uom2.uom_class
AND class.uom_class       = uom1.uom_class
AND uom2.base_uom_flag    = 'Y'
AND UOM1.BASE_UOM_FLAG    = 'N'
AND UNITOFMEASURECONVERSIONEO.UOM_CODE        = UOM1.UOM_CODE
ORDER BY uom1.unit_of_measure